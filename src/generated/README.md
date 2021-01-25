# Setup

_Please ensure you have `gsed` installed if you are on macOS or FreeBSD._

```bash
julia -E 'import Pkg; Pkg.add("ProtoBuf")'
brew install protobuf # or similar for your package manager
cd GraknClient.jl
git switch protoc-gen
mkdir -p src/generated/protobuf/
git clone https://github.com/graknlabs/protocol.git/
mv protocol/protobuf/* src/generated/protobuf/ && rm -rf protocol
cd src/generated/
julia --project=protobuf/ProtoBuf.jl/ -E 'import Pkg; Pkg.instantiate()'
git clone https://github.com/JuliaIO/ProtoBuf.jl/ protobuf/ProtoBuf.jl/
echo 'export PATH="$PATH:'$PWD'/protobuf/ProtoBuf.jl/plugin/"' >> $HOME/.bashrc && . $HOME/.bashrc
if [[ "$(uname -s)" == "Darwin" ]] || [[ "$(uname -s)" == "FreeBSD" ]]; then
	SED="gsed"
else
	SED="sed"
end
for i in protobuf/*; do # correct imports
	[ "${file##*.}" == "proto" ] || continue
	$SED -i 's|\(import\s\)\"protobuf\/\(.*\.proto\)\"\;|\1\"\2\"\;|g' $i
done
for i in protobuf/*; do # generate files
    [[ -d $i ]] && continue
    [[ $i == "BUILD" ]] || protoc -I=protobuf --julia_out=. $i
done
```

You may also use
