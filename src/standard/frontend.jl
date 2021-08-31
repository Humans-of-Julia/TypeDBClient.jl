const DATA_SESSION = typedb.protocol.Session_Type.DATA
const SCHEMA_SESSION = typedb.protocol.Session_Type.SCHEMA

function dbconnect(f::Base.Callable, host::AbstractString, port::Int = 1729)
    client = CoreClient(host)
    try
        f(client)
    finally
        # close(client)
    end
end

function Base.open(
    f::Function,
    client::AbstractCoreClient,
    schema::AbstractString,
    type = DATA_SESSION
)
    session = Session(client, schema, type)
    try
        f(session)
    finally
        close(session)
    end
end

function readwrite(
    f::Function,
    session::AbstractCoreSession,
    direction::Integer,
    options::TypeDBOptions
)
    transaction = Transaction(session, session.sessionID, direction, options)
    try
        f(transaction)
    finally
        close(transaction)
    end
end

function Base.read(
    f::Function,
    session::AbstractCoreSession,
    options::TypeDBOptions = TypeDBOptions()
)
    readwrite(f, session, typedb.protocol.Transaction_Type.READ, options)
end

function Base.write(
    f::Function,
    session::AbstractCoreSession,
    options::TypeDBOptions = TypeDBOptions()
)
    readwrite(f, session, typedb.protocol.Transaction_Type.WRITE, options)
end
