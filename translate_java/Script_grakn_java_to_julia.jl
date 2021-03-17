using Pkg
using ProtoBuf

root_dir_java = "/Users/frank/Documents/JuliaProjects/JuliaSource/GraknClient/client-java"
root_dir = "/Users/frank/Documents/JuliaProjects/JuliaSource/GraknClient/GraknClient.jl/src"


license_text = "# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE \n"

reg_license = r"( \*.+\n)|(\/\*\n)|( \*\n)"

#empty the source code directory
rm(root_dir;force = true, recursive = true)
#make a new source code directory 
mkdir(root_dir)

#read the conent of the java directory and throw away all not necessary
dirs_java = readdir(root_dir_java)
result_dirs_java = filter(x->(!startswith(x,'.') && (!isfile(joinpath(root_dir_java,x)) && (x != "docs"))  ),dirs_java) 

#copy the source structure from java to the julia grakn client
for dir in result_dirs_java 
    cp(joinpath(root_dir_java * "/" * dir), root_dir * "/" * dir)
end

#get the GraknClient.jl and bring it in place
download("https://raw.githubusercontent.com/Humans-of-Julia/GraknClient.jl/main/src/GraknClient.jl", root_dir * "/GraknClient.jl")

function prepare_java_file(full_filepath::String)
    #read the given file
    text_lines = readlines(full_filepath;keep=true)

    #prepare the first lines
    result_lines = [license_text, "\n"]

    #take the text array, go trough an let beside the 
    #license lines 

    #put the rest of the lines on top of the prepared 
    #result_lines array
    for i in 1:length(text_lines)
        test = match(reg_license, text_lines[i])
        if test === nothing
            tmp_line = "# " * text_lines[i]
            push!(result_lines, tmp_line)
        end
    end
    #join the text-array to a string
    text_result = join(result_lines,"","")

    # write back file
    file_io = open(full_filepath,"w")
    write(file_io, text_result)
    close(file_io)

    #change filename
    mv(full_filepath, replace(full_filepath,".java"=>".jl"))
end

#do the work to change the files
for (root, dirs, files) in walkdir(root_dir)
    for file in files 
        if !occursin(".git", root) && !occursin(".github", root) && endswith(file, ".java")
            prepare_java_file(joinpath(root, file)) 
            println(joinpath(root, file))
        end
    end
end

#remove the BUILD Files
for (root, dirs, files) in walkdir(root_dir)
    for file in files 
        if file == "BUILD"
            rm(joinpath(root,file))
            println(joinpath(root,file), " : deleted")
        end
    end
end

#make the generated folder
mkdir(root_dir * "/generated")

#get the actual proto files
command_split = string.(split("git clone -b architecture-refactor https://github.com/haikalpribadi/protocol.git", " "))
push!(command_split, joinpath(root_dir,"generated","protocol"))
command = Cmd(command_split)
run(command)

#copy protobuf to generated an remove protocol
cp(joinpath(root_dir,"generated","protocol","protobuf"), joinpath(root_dir,"generated", "protobuf"))
rm(joinpath(root_dir,"generated","protocol"), force = true, recursive = true)

#prepare the proto file
function prepare_proto_file(filepath::String)
    #reading text
    text = readlines(filepath, keep = true)

    #replacing the needed
    for i in 1:length(text)
        #replacing the extension protobuf
        text[i]=replace(text[i], "import \"protobuf/"=>"import \"")
        #replacing the extension cluster
        text[i]=replace(text[i], "import \"cluster/"=>"import \"")
        if basename(filepath) == "grakn.proto"
            text[i] = replace(text[i], "option java_outer_classname = \"GraknProto\";" => "option java_outer_classname = \"GraknProto\"; \noption java_generic_services = true;")
        end
    end
    result = join(text,"","")
    #write back the resul
    io_stream = open(filepath,"w")
    write(io_stream, result)
    close(io_stream)
end

#change the protofiles to the needs
for (root, dirs, files) in walkdir(joinpath(root_dir,"generated","protobuf"))
    for file in files 
        if endswith(file, ".proto")
            prepare_proto_file(joinpath(root, file)) 
            println(joinpath(root, file))
        end
        if file == "BUILD"
            rm(joinpath(root,file))
        end
    end
end

# Die Aufbereitung der Files muss noch erledigt werden.
# Die directories sollten absolut gesetzt werden.
command_arr = String[]
push!(command_arr, "-I=" * joinpath(root_dir,"generated","protobuf"))
push!(command_arr, "--julia_out=" * joinpath(root_dir,"generated"))
push!(command_arr, joinpath(root_dir,"generated","protobuf","options.proto"))

cmd = Cmd(command_arr)
run(ProtoBuf.protoc(cmd))

#Reading the grakn_pb.jl and change the clasnames to 
regex_change = r"(grakn\.protocol\.)(\w+\.){2}(\w+)|(?<=\{)(grakn\.protocol\.)(\w+\.){1}(\w+)(?=\})"
text_grakn_pb = open(f->read(f,String) ,joinpath(root_dir,"generated","grakn_pb.jl"))
text_copy = deepcopy(text_grakn_pb)
matches_to_change = collect(eachmatch(regex_change,text_grakn_pb))
dict_Result = Dict{String,String}()

for mat in matches_to_change
    string_match = mat.match
    splits = split(string_match, ".")
    result_string = ""
    temp_word = String[]
    for word in splits
        if word == "grakn" || word == "protocol"
            result_string *= word * "."
        else    
            push!(temp_word, word)
        end
    end
    result = result_string * join(temp_word,"_")
    dict_Result[string_match] = result
end

for (key, value) in dict_Result
    text_copy = replace(text_copy, key=>value)
end

file_io = open(joinpath(root_dir,"generated","grakn_pb.jl"),"w")
write(file_io, text_copy)
close(file_io)
