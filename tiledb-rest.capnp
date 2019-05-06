@0xb57d9224b587d87f;

using Cxx = import "/capnp/c++.capnp";
$Cxx.namespace("tiledb::rest::capnp");

struct DomainArray {
  int8 @0 :List(Int8);
  uint8 @1 :List(UInt8);
  int16 @2 :List(Int16);
  uint16 @3 :List(UInt16);
  int32 @4 :List(Int32);
  uint32 @5 :List(UInt32);
  int64 @6 :List(Int64);
  uint64 @7 :List(UInt64);
  float32 @8 :List(Float32);
  float64 @9 :List(Float64);
}

struct Array {
  timestamp @0 :UInt64;
  # timestamp array was opened

  encryptionKey @1 :Data;
  # Key used for encryption

  encryptionType @2 :Text;
  # Encryption type used for array

  lastMaxBufferSizes @3 :MapMaxBufferSizes;
  # Last max buffer sizes

  lastMaxBufferSizesSubarray @4 :DomainArray;
  # Last max buffer sizes subarray

  queryType @5 :Text;
  # Array opened for query type

  uri @6 :Text;
  # Array uri
}

struct ArraySchema {
# ArraySchema during creation or retrevial
    arrayType @0 :Text;
    # Type of array

    attributes @1 :List(Attribute);
    # Attributes of array

    capacity @2 :UInt64;
    # Capacity of array

    cellOrder @3 :Text;
    # Order of cells

    coordsFilterPipeline @4 :FilterPipeline;
    # Type of compression for coordinates (enum)

    domain @5 :Domain;
    # Domain of array

    offsetFilterPipeline @6 :FilterPipeline;
    # Compression type of cell variable offsets (enum)

    tileOrder @7 :Text;
    # Tile order setting of array

    uri @8 :Text;
    # URI of schema

    version @9 :List(Int32);
    # file format version
}

struct Attribute {
# Attribute of array
    cellValNum @0 :UInt32;
    # Attribute number of values per cell

    name @1 :Text;
    # Attribute name

    type @2 :Text;
    # TileDB attribute datatype

    filterPipeline @3 :FilterPipeline;
    # TileDB FilterPipeline for Attribute
}

struct AttributeBufferHeader {
# Represents an attribute buffer header information

    name @0 :Text;
    # Attribute name

    fixedLenBufferSizeInBytes @1 :UInt64;
    # Number of bytes in the fixed-length attribute data buffer

    varLenBufferSizeInBytes @2 :UInt64;
    # Number of bytes in the var-length attribute data buffer
}

struct Dimension {
# Dimension of array

    name @0 :Text;
    # Dimension name

    nullTileExtent @1 :Bool;
    # Is tile extent null

    type @2 :Text;
    # Datatype for Dimension

    tileExtent :union {
      int8 @3 :Int8;
      uint8 @4 :UInt8;
      int16 @5 :Int16;
      uint16 @6 :UInt16;
      int32 @7 :Int32;
      uint32 @8 :UInt32;
      int64 @9 :Int64;
      uint64 @10 :UInt64;
      float32 @11 :Float32;
      float64 @12 :Float64;
    }
    # Extent of tile

    domain @13 :DomainArray;
    # extent of domain
}

struct Domain {
# Domain of array
    cellOrder @0 :Text;
    # Tile Order

    dimensions @1 :List(Dimension);
    # Array of dimensions

    tileOrder @2 :Text;
    # Tile Order

    type @3 :Text;
    # Datatype of domain
}

struct Error {
    code @0 :Int64;
    message @1 :Text;
}

struct Filter {
  type @0 :Text;
  # filter type

  data :union {
    text @1 :Text;
    bytes @2 :Data;
    int8 @3 :Int8;
    uint8 @4 :UInt8;
    int16 @5 :Int16;
    uint16 @6 :UInt16;
    int32 @7 :Int32;
    uint32 @8 :UInt32;
    int64 @9 :Int64;
    uint64 @10 :UInt64;
    float32 @11 :Float32;
    float64 @12 :Float64;
  }
  # filter data
}

struct FilterPipeline {
  filters @0 :List(Filter);
}

struct Map(Key, Value) {
  entries @0 :List(Entry);
  struct Entry {
    key @0 :Key;
    value @1 :Value;
  }
}

struct MapUInt32 {
  entries @0 :List(Entry);
  struct Entry {
    key @0 :Text;
    value @1 :UInt32;
  }
}

struct MapInt64 {
  entries @0 :List(Entry);
  struct Entry {
    key @0 :Text;
    value @1 :Int64;
  }
}

struct MaxBufferSize {
  bufferOffsetSize @0 :UInt64;
  # size of buffer offsets

  bufferSize @1 :UInt64;
  # size of bufffer
}

struct MapMaxBufferSizes {
  entries @0 :List(Entry);
  struct Entry {
    key @0 :Text;
    value @1 :MaxBufferSize;
  }
}

struct Writer {
  # Write struct
  checkCoordDups @0 :Bool;

  dedupCoords @1 :Bool;

  initialized @2 :Bool;

  fragmentUri @3 :Text;
}

struct ReadState {
  initialized @0 :Bool;
  # True if the reader has been initialized.

  overflowed @1 :Bool;
  # `True` if the query produced results that could not fit in some buffer.

  unsplittable @2 :Bool;
  # True if the current subarray partition is unsplittable.

  subarray @3 :DomainArray;
  # The original subarray set by the user.

  curSubarrayPartition @4 :DomainArray;
  # The current subarray the query is constrained on.

  subarrayPartitions @5 :List(DomainArray);
  # A list of subarray partitions. The head of the list is the partition
  # to be split next.
}

struct QueryReader {
  # Read struct (can't be called reader due to class name conflict)

  readState @0 :ReadState;
  # To handle incomplete read queries.
}

struct Query {
    attributeBufferHeaders @0 :List(AttributeBufferHeader);
    # list of attribute buffer headers

    layout @1 :Text;
    # query write layout

    status @2 :Text;
    # query status

    type @3 :Text;
    # Type of query

    writer @4 :Writer;
    # writer contains data needed for continuation of global write order queries

    reader @5 :QueryReader;
    # reader contains data needed for continuation of incomplete reads

    subarray @6 :DomainArray;
    # Limit dense operations to these dimensions

    array @7 :Array;
    # Represents an open array

    totalFixedLengthBufferBytes @8: UInt64;
    # Total number of bytes in fixed size attribute buffers

    totalVarLenBufferBytes @9: UInt64;
    # Total number of bytes in variable size attribute buffers
}

struct NonEmptyDomain {
  # object representing a non-empty domain

  nonEmptyDomain @0 :Map(Text, DomainArray);
  # Non Empty Dmoain of array

  isEmpty @1 :Bool;
  # Is non-empty domain really empty?
}

struct MaxBufferSizeVar {
  # used to return max buffer/var buffer sizes for an array

  attribute @0 :Text;
  # name of attribute

  bufferSize @1 :UInt64;
  # max size of a buffer for given subarray

  bufferOffsetSize @2 :UInt64;
  # max buffer offset for a given subarray
}
