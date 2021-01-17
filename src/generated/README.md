# Setup

```bash
julia -E 'import Pkg; Pkg.add("ProtoBuf")'
brew install protobuf # or similar for your package manager
cd GraknClient.jl
git switch protoc-gen
mkdir -p src/generated/protoc/
git clone https://github.com/graknlabs/protocol.git/
mv protocol/protobuf/* src/generated/protoc/ && rm -rf protocol
cd src/generated/
julia --project=protoc/ProtoBuf.jl/ -E 'import Pkg; Pkg.instantiate()'
git clone https://github.com/JuliaIO/ProtoBuf.jl/ protoc/ProtoBuf.jl/
echo 'PATH="$PATH:/some/path/to/GraknGlient.jl/src/generated/protoc/ProtoBuf.jl/plugin/"' >> $HOME/.bashrc && . $HOME/.bashrc # INSERT DIR PATH HERE
for i in protoc/*; do
    [[ -d $i ]] && continue
    [[ $i == "BUILD" ]] || protoc -I=protoc --julia_out=. $i
done
```
