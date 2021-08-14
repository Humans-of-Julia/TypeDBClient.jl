const __bodyfunction__ = Dict{Method,Any}()

# Find keyword "body functions" (the function that contains the body
# as written by the developer, called after all missing keyword-arguments
# have been assigned values), in a manner that doesn't depend on
# gensymmed names.
# `mnokw` is the method that gets called when you invoke it without
# supplying any keywords.
function __lookup_kwbody__(mnokw::Method)
    function getsym(arg)
        isa(arg, Symbol) && return arg
        @assert isa(arg, GlobalRef)
        return arg.name
    end

    f = get(__bodyfunction__, mnokw, nothing)
    if f === nothing
        fmod = mnokw.module
        # The lowered code for `mnokw` should look like
        #   %1 = mkw(kwvalues..., #self#, args...)
        #        return %1
        # where `mkw` is the name of the "active" keyword body-function.
        ast = @assert Base.uncompressed_ast(mnokw)
        if isa(ast, Core.CodeInfo) && length(ast.code) >= 2
            callexpr = ast.code[end-1]
            if isa(callexpr, Expr) && callexpr.head == :call
                fsym = callexpr.args[1]
                if isa(fsym, Symbol)
                    f = getfield(fmod, fsym)
                elseif isa(fsym, GlobalRef)
                    if fsym.mod === Core && fsym.name === :_apply
                        f = getfield(mnokw.module, getsym(callexpr.args[2]))
                    elseif fsym.mod === Core && fsym.name === :_apply_iterate
                        f = getfield(mnokw.module, getsym(callexpr.args[3]))
                    else
                        f = getfield(fsym.mod, fsym.name)
                    end
                else
                    f = missing
                end
            else
                f = missing
            end
        else
            f = missing
        end
        __bodyfunction__[mnokw] = f
    end
    return f
end

function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    @assert Base.precompile(Tuple{typeof(get_has),AbstractCoreTransaction,AbstractThing,Nothing})   # time: 0.20792879
    @assert Base.precompile(Tuple{typeof(delete),RemoteConcept{Attribute{1, Bool}, CoreTransaction}})   # time: 0.1345733
    @assert Base.precompile(Tuple{typeof(set_regex),RemoteConcept{AttributeType{4}, CoreTransaction},String})   # time: 0.106783904
    @assert Base.precompile(Tuple{typeof(set_owns),TypeDBClient.RemoteConcept{C<:TypeDBClient.AbstractType, T<:TypeDBClient.AbstractCoreTransaction},AbstractType,Bool})   # time: 0.098165184
    @assert Base.precompile(Tuple{typeof(get_has),CoreTransaction,Entity,AttributeType{4}})   # time: 0.09777294
    @assert Base.precompile(Tuple{typeof(get_owners),TypeDBClient.RemoteConcept{C<:TypeDBClient.AbstractAttributeType, T<:TypeDBClient.AbstractCoreTransaction},Any})   # time: 0.0960854
    @assert Base.precompile(Tuple{typeof(get),ConceptManager{CoreTransaction},Type{AttributeType},String})   # time: 0.09301386
    @assert Base.precompile(Tuple{typeof(set_plays),RemoteConcept{EntityType, CoreTransaction},RoleType})   # time: 0.087889984
    @assert Base.precompile(Tuple{typeof(set_relates),CoreTransaction,Label,String})   # time: 0.0843605
    @assert Base.precompile(Tuple{typeof(get_relates),RemoteConcept{RelationType, CoreTransaction}})   # time: 0.083583735
    @assert Base.precompile(Tuple{typeof(add_player),CoreTransaction,Relation,RoleType,Entity})   # time: 0.07681739
    @assert Base.precompile(Tuple{typeof(insert),CoreTransaction,String})   # time: 0.07660754
    @assert Base.precompile(Tuple{typeof(delete_database),CoreClient,String})   # time: 0.07572446
    @assert Base.precompile(Tuple{typeof(unset_has),CoreTransaction,Entity,Attribute{4, String}})   # time: 0.07563982
    @assert Base.precompile(Tuple{typeof(put),RemoteConcept{AttributeType{1}, CoreTransaction},Bool})   # time: 0.07494374
    @assert Base.precompile(Tuple{typeof(define),CoreTransaction,String})   # time: 0.072422095
    @assert Base.precompile(Tuple{typeof(get_supertype),RemoteConcept{AttributeType{4}, CoreTransaction}})   # time: 0.07074542
    @assert Base.precompile(Tuple{typeof(create),RemoteConcept{RelationType, CoreTransaction}})   # time: 0.07051015
    @assert Base.precompile(Tuple{typeof(create),RemoteConcept{EntityType, CoreTransaction}})   # time: 0.069268495
    @assert Base.precompile(Tuple{typeof(get_relations),CoreTransaction,Entity})   # time: 0.06293514
    @assert Base.precompile(Tuple{typeof(unset_relates),RemoteConcept{RelationType, CoreTransaction},String})   # time: 0.061232843
    @assert Base.precompile(Tuple{typeof(get),RemoteConcept{AttributeType{3}, CoreTransaction},Float64})   # time: 0.060380004
    @assert Base.precompile(Tuple{typeof(relation_type_get_relates_for_role_label),RemoteConcept{RelationType, CoreTransaction},String})   # time: 0.058965605
    @assert Base.precompile(Tuple{typeof(get_players),CoreTransaction,Relation,Vector{RoleType}})   # time: 0.05876938
    @assert Base.precompile(Tuple{typeof(commit),CoreTransaction})   # time: 0.056737244
    @assert Base.precompile(Tuple{typeof(unset_owns),RemoteConcept{AttributeType{4}, CoreTransaction},AttributeType{4}})   # time: 0.055531282
    @assert Base.precompile(Tuple{typeof(set_supertype),RemoteConcept{AttributeType{4}, CoreTransaction},AttributeType{4}})   # time: 0.05539763
    @assert Base.precompile(Tuple{typeof(get_instances),RemoteConcept{AttributeType{1}, CoreTransaction}})   # time: 0.05446929
    @assert Base.precompile(Tuple{typeof(safe_close),AbstractCoreSession})   # time: 0.054430697
    @assert Base.precompile(Tuple{typeof(is_deleted),RemoteConcept{Attribute{1, Bool}, CoreTransaction}})   # time: 0.051830288
    @assert Base.precompile(Tuple{typeof(unset_plays),RemoteConcept{EntityType, CoreTransaction},RoleType})   # time: 0.051627696
    @assert Base.precompile(Tuple{typeof(set_label),RemoteConcept{AttributeType{4}, CoreTransaction},String})   # time: 0.0511191
    @assert Base.precompile(Tuple{typeof(put),RemoteConcept{AttributeType{5}, CoreTransaction},DateTime})   # time: 0.04719047
    @assert Base.precompile(Tuple{typeof(put),RemoteConcept{AttributeType{3}, CoreTransaction},Float64})   # time: 0.046606965
    @assert Base.precompile(Tuple{typeof(set_has),CoreTransaction,Entity,Attribute{4, String}})   # time: 0.04316875
    @assert Base.precompile(Tuple{typeof(remove_player),CoreTransaction,Relation,RoleType,Entity})   # time: 0.04290574
    @assert Base.precompile(Tuple{typeof(get_plays),RemoteConcept{EntityType, CoreTransaction}})   # time: 0.042349648
    @assert Base.precompile(Tuple{typeof(get_players),CoreTransaction,Label})   # time: 0.04140722
    @assert Base.precompile(Tuple{typeof(set_abstract),RemoteConcept{AttributeType{4}, CoreTransaction}})   # time: 0.040902257
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,AttributeType{1}})   # time: 0.040049244
    @assert Base.precompile(Tuple{typeof(get_subtypes),RemoteConcept{AttributeType{0}, CoreTransaction}})   # time: 0.039398674
    @assert Base.precompile(Tuple{typeof(put),ConceptManager{CoreTransaction},Type{EntityType},String})   # time: 0.0385238
    @assert Base.precompile(Tuple{typeof(get_supertypes),RemoteConcept{AttributeType{4}, CoreTransaction}})   # time: 0.03837752
    @assert Base.precompile(Tuple{typeof(is_abstract),RemoteConcept{AttributeType{4}, CoreTransaction}})   # time: 0.038063936
    @assert Base.precompile(Tuple{Type{TypeDBClientException},gRPCServiceCallException})   # time: 0.03784583
    @assert Base.precompile(Tuple{typeof(delete),RemoteConcept{AttributeType{2}, CoreTransaction}})   # time: 0.03780745
    @assert Base.precompile(Tuple{typeof(get_regex),RemoteConcept{AttributeType{4}, CoreTransaction}})   # time: 0.037674006
    @assert Base.precompile(Tuple{typeof(put),ConceptManager{CoreTransaction},Type{RelationType},String})   # time: 0.035023324
    @assert Base.precompile(Tuple{typeof(get_owners),CoreTransaction,Attribute{4, String},Nothing})   # time: 0.03105284
    @assert Base.precompile(Tuple{typeof(set_relates),CoreTransaction,Label,String,String})   # time: 0.030268086
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{RelationType, CoreTransaction},AttributeType{5},Bool})   # time: 0.026565986
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{EntityType, CoreTransaction},AttributeType{4},Bool,AttributeType{4}})   # time: 0.022395384
    @assert Base.precompile(Tuple{typeof(put),RemoteConcept{AttributeType{4}, CoreTransaction},String})   # time: 0.022136612
    @assert Base.precompile(Tuple{typeof(show),IOBuffer,TypeDBClientException})   # time: 0.021493329
    @assert Base.precompile(Tuple{typeof(put),RemoteConcept{AttributeType{2}, CoreTransaction},Int64})   # time: 0.02139181
    @assert Base.precompile(Tuple{typeof(set_supertype),RemoteConcept{RelationType, CoreTransaction},RelationType})   # time: 0.019979574
    @assert Base.precompile(Tuple{typeof(get_has),CoreTransaction,Entity,Nothing,Nothing,Bool})   # time: 0.019800128
    @assert Base.precompile(Tuple{typeof(get_subtypes),RemoteConcept{AttributeType{4}, CoreTransaction}})   # time: 0.019389277
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{EntityType, CoreTransaction},AttributeType{4},Bool,Nothing})   # time: 0.018238833
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{EntityType, CoreTransaction},AttributeType{5},Bool,Nothing})   # time: 0.017889416
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{EntityType, CoreTransaction},AttributeType{3},Bool,Nothing})   # time: 0.017141787
    @assert Base.precompile(Tuple{Type{CoreSession},T<:TypeDBClient.AbstractCoreClient,String,Int32,TypeDBOptions})   # time: 0.01704403
    @assert Base.precompile(Tuple{typeof(show),IOContext{IOBuffer},TypeDBClient.typedb.protocol.Transaction_Res})   # time: 0.015525168
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{EntityType, CoreTransaction},AttributeType{2},Bool,Nothing})   # time: 0.015151014
    @assert Base.precompile(Tuple{typeof(safe_close),CoreSession})   # time: 0.014527294
    @assert Base.precompile(Tuple{typeof(set_owns),RemoteConcept{EntityType, CoreTransaction},AttributeType{1},Bool,Nothing})   # time: 0.014119137
    @assert Base.precompile(Tuple{typeof(set_supertype),RemoteConcept{EntityType, CoreTransaction},EntityType})   # time: 0.013897635
    @assert Base.precompile(Tuple{Type{CoreSession},CoreClient,String,Int32,TypeDBOptions})   # time: 0.012899116
    @assert Base.precompile(Tuple{typeof(set_plays),RemoteConcept{EntityType, CoreTransaction},RoleType,RoleType})   # time: 0.012677207
    @assert Base.precompile(Tuple{typeof(get_relations),CoreTransaction,Entity,Vector{RoleType}})   # time: 0.012042414
    let fbody = try __lookup_kwbody__(which(CoreTransaction, (CoreSession,Vector{UInt8},Int32,TypeDBOptions,))) catch missing end
        if !ismissing(fbody)
            precompile(fbody, (Int64,Type{CoreTransaction},CoreSession,Vector{UInt8},Int32,TypeDBOptions,))
        end
    end   # time: 0.009391064
    @assert Base.precompile(Tuple{typeof(set_has),AbstractCoreTransaction,AbstractThing,Attribute})   # time: 0.00612314
    @assert Base.precompile(Tuple{typeof(show),IOContext{IOBuffer},CoreTransaction})   # time: 0.006088176
    @assert Base.precompile(Tuple{Type{TypeDBClientException},Type{CLIENT_DB_DOES_NOT_EXIST},String})   # time: 0.006049753
    @assert Base.precompile(Tuple{typeof(show),IOContext{IOBuffer},TypeDBClientException})   # time: 0.005898614
    @assert Base.precompile(Tuple{typeof(create_database),CoreClient,String})   # time: 0.00460053
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,AttributeType{5}})   # time: 0.002787852
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,ThingType})   # time: 0.002486538
    @assert Base.precompile(Tuple{typeof(get_players),CoreTransaction,Relation})   # time: 0.002291782
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,AttributeType{2}})   # time: 0.001957885
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,AttributeType{3}})   # time: 0.00195171
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,EntityType})   # time: 0.001927139
    @assert Base.precompile(Tuple{Type{ConceptManager},T<:TypeDBClient.AbstractCoreTransaction})   # time: 0.001913049
    @assert Base.precompile(Tuple{typeof(is_deleted),RemoteConcept{Attribute{2, Int64}, CoreTransaction}})   # time: 0.001830018
    @assert Base.precompile(Tuple{typeof(set_plays),RemoteConcept{RelationType, CoreTransaction},RoleType})   # time: 0.001827876
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,AttributeType{4}})   # time: 0.001819846
    @assert Base.precompile(Tuple{typeof(==),AbstractThingType,RelationType})   # time: 0.00176351
    @assert Base.precompile(Tuple{typeof(is_deleted),RemoteConcept{Attribute{3, Float64}, CoreTransaction}})   # time: 0.001718299
    @assert Base.precompile(Tuple{typeof(is_deleted),RemoteConcept{Relation, CoreTransaction}})   # time: 0.001675425
    @assert Base.precompile(Tuple{typeof(==),AttributeType,AttributeType{3}})   # time: 0.001643634
    @assert Base.precompile(Tuple{typeof(==),AttributeType,AttributeType{0}})   # time: 0.001617487
    @assert Base.precompile(Tuple{typeof(==),AttributeType,AttributeType{5}})   # time: 0.001596891
    @assert Base.precompile(Tuple{typeof(==),AttributeType,AttributeType{2}})   # time: 0.001561365
    @assert Base.precompile(Tuple{typeof(==),AttributeType,AttributeType{1}})   # time: 0.00154353
    @assert Base.precompile(Tuple{typeof(==),AttributeType,AttributeType{4}})   # time: 0.001541135
    @assert Base.precompile(Tuple{typeof(show),IOContext{IOBuffer},TypeDBClient.typedb.protocol.Transaction_ResPart})   # time: 0.001488649
    @assert Base.precompile(Tuple{typeof(get_instances),RemoteConcept{ThingType, CoreTransaction}})   # time: 0.001308863
    @assert Base.precompile(Tuple{typeof(get_owns),RemoteConcept{AttributeType{4}, CoreTransaction},Nothing,Bool})   # time: 0.001208411
    @assert Base.precompile(Tuple{typeof(get_instances),RemoteConcept{AttributeType{5}, CoreTransaction}})   # time: 0.001183957
    @assert Base.precompile(Tuple{typeof(get),RemoteConcept{AttributeType{4}, CoreTransaction},String})   # time: 0.001130905
    @assert Base.precompile(Tuple{typeof(is_deleted),RemoteConcept{Attribute{4, String}, CoreTransaction}})   # time: 0.00109062
    @assert Base.precompile(Tuple{typeof(get_supertypes),RemoteConcept{ThingType, CoreTransaction}})   # time: 0.001069081
    @assert Base.precompile(Tuple{typeof(get_instances),RemoteConcept{AttributeType{3}, CoreTransaction}})   # time: 0.001054424
    @assert Base.precompile(Tuple{typeof(set_has),CoreTransaction,Relation,Attribute{4, String}})   # time: 0.001047934
    @assert Base.precompile(Tuple{typeof(get_instances),RemoteConcept{AttributeType{2}, CoreTransaction}})   # time: 0.001025225
    @assert Base.precompile(Tuple{typeof(get),ConceptManager,Type{AttributeType},String})   # time: 0.00100935
end
