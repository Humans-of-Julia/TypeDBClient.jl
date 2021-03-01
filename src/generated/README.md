# Setup

```bash
julia -E 'import Pkg; Pkg.add("ProtoBuf")'
brew install protobuf # or similar for your package manager
cd GraknClient.jl
git switch protoc-gen
mkdir -p src/generated/protobuf/
mkdir -p src/generated/cluster/
git clone https://github.com/graknlabs/protocol.git/
mv protocol/protobuf/* src/generated/protobuf/ && rm -rf protocol
cd src/generated/
julia --project=protobuf/ProtoBuf.jl/ -E 'import Pkg; Pkg.instantiate()'
git clone https://github.com/JuliaIO/ProtoBuf.jl/ protobuf/ProtoBuf.jl/
echo 'export PATH="$PATH:/some/path/to/GraknClient.jl/src/generated/protobuf/ProtoBuf.jl/plugin/"' >> $HOME/.bashrc && . $HOME/.bashrc # INSERT DIR PATH HERE

for i in protobuf/*; do
    [[ -d $i ]] && continue
    [[ $i == "BUILD" ]] || protoc -I=protobuf --julia_out=. $i
done

for i in protobuf/cluster/*; do
    [[ -d $i ]] && continue
    [[ $i == "BUILD" ]] || protoc -I=protobuf --julia_out=cluster $i
done
```
