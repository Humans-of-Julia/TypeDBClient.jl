using Pkg
using ProtoBuf

root_dir_java = "/Users/frank/Documents/JuliaProjects/JuliaSource/GraknClient/client-java"
root_dir = "/Users/frank/Documents/JuliaProjects/JuliaSource/GraknClient/GraknClient.jl/src"


license_text = "# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE \n"

reg_license = r"( \*.+\n)|(\/\*\n)|( \*\n)"

#make the generated folder
mkdir(root_dir * "/generated")

#get the actual proto files
command_split = string.(split("git clone -b master https://github.com/graknlabs/protocol.git", " "))
push!(command_split, joinpath(root_dir,"generated","protocol"))
command = Cmd(command_split)
run(command)

#copy protobuf to generated an remove protocol
src_dir =joinpath(root_dir,"generated","protocol")
file_arr = String[]
protobuf_arr = String[]

for (root,dirs,files) in walkdir(src_dir)
    for file in files
        if occursin(".proto", basename(file)) && occursin("cluster",root)
            push!(file_arr,joinpath(root,file))
        elseif occursin(".proto", basename(file))
            push!(protobuf_arr,joinpath(root,file))
        end
    end
end

mkdir(joinpath(root_dir,"generated","protobuf"))
mkdir(joinpath(root_dir,"generated","protobuf","cluster"))

for file in file_arr
    cp(file,joinpath(root_dir,"generated","protobuf","cluster",basename(file)))
end

for file in protobuf_arr
    cp(file,joinpath(root_dir,"generated","protobuf",basename(file)))
end

rm(joinpath(root_dir,"generated","protocol"), force = true, recursive = true)


#prepare the proto file
reg_proto = r"""import\s+"\w+\/"""

function prepare_proto_file(filepath::String)
    #reading text
    text = readlines(filepath, keep = true)

    #replacing the needed
    for i in 1:length(text)
        #replacing the extension protobuf
        text[i]=replace(text[i], reg_proto=>"import \"")
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
push!(command_arr, string(joinpath(root_dir,"generated","protobuf","*.proto")))

cmd = Cmd(command_arr)
#do this manually
run(ProtoBuf.protoc(cmd))

#Reading the core_service_pb.jl and change the clasnames to
regex_change = r"(grakn\.protocol\.)(\w+\.){2}(\w+)|(?<=\{)(grakn\.protocol\.)(\w+\.){1}(\w+)(?=\})"
text_grakn_pb = open(f->read(f,String) ,joinpath(root_dir,"generated","core_service_pb.jl"))
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

#write back grakn_pb.jl
write(joinpath(root_dir,"generated","core_service_pb.jl"), text_copy)

#removing the grakn_pb.jl line in grakn.jl because it givs some trouble with including
grakn_jl_text = open(f->read(f,String), joinpath(root_dir,"generated","grakn.jl"))
reg_tex = r".*include\(\"core_service_pb.jl\"\).*\s+"
matches_to_change = collect(eachmatch(reg_tex, grakn_jl_text))
grakn_jl_text = replace(grakn_jl_text, matches_to_change[1].match=>"")

write(joinpath(root_dir,"generated","grakn.jl"), grakn_jl_text)
