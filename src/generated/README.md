# Setup

```bash
julia -E 'import Pkg; Pkg.add("ProtoBuf")'
brew install protobuf # or similar for your package manager
echo 'PATH="$PATH:$HOME/dev/ProtoBuf.jl/plugin/"' >> $HOME/.bashrc && . $HOME/.bashrc
cd GraknClient.jl
git switch protoc-gen
mkdir -p src/generated/protoc/
git clone https://github.com/graknlabs/protocol.git/
mv protocol/protobuf/* src/generated/protoc/ && rm -rf protocol
cd src/generated/
for i in protoc/*
    protoc -I=proto --julia_out=. proto/$i
done
```
