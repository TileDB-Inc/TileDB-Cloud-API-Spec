@0xb57d9224b587d87f;

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

struct AttributeBuffer {
# Represents an attribute buffer
    type @0 :Text;

    buffer :union {
      int8 @1 :List(Int8);
      uint8 @2 :List(UInt8);
      int16 @3 :List(Int16);
      uint16 @4 :List(UInt16);
      int32 @5 :List(Int32);
      uint32 @6 :List(UInt32);
      int64 @7 :List(Int64);
      uint64 @8 :List(UInt64);
      float32 @9 :List(Float32);
      float64 @10 :List(Float64);
      char @11 :Data;
    }

    # offset buffer for variable length attributes
    bufferOffset @12 :List(UInt64);
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

struct FragmentMetadata {
  attributeIdxMap @0 :MapUInt32;
  # Maps an attribute to an index used in the various vector class members.

  attributeUriMap @1 :Map(Text, Text);
  # Maps an attribute to its absolute URI within this fragment.

  attributeVarUriMap @2 :Map(Text, Text);
  # Maps an attribute to its absolute '_var' URI within this fragment.

  boundingCoords :union {
      int8 @3 :List(List(Int8));
      uint8 @4 :List(List(UInt8));
      int16 @5 :List(List(Int16));
      uint16 @6 :List(List(UInt16));
      int32 @7 :List(List(Int32));
      uint32 @8 :List(List(UInt32));
      int64 @9 :List(List(Int64));
      uint64 @10 :List(List(UInt64));
      float32 @11 :List(List(Float32));
      float64 @12 :List(List(Float64));
    }
  # A vector storing the first and last coordinates of each tile.

  dense @13 :Bool;
  # True if the fragment is dense, and false if it is sparse.

  domain @14 :DomainArray;
  # The (expanded) domain in which the fragment is constrained. "Expanded"
  # means that the domain is enlarged minimally to coincide with tile
  # boundaries (if there is a tile grid imposed by tile extents). Note that the
  # type of the domain must be the same as the type of the array coordinates.


  fileSizes @15 :List(UInt64);
  # Stores the size of each attribute file.

  fileVarSizes @16 :List(UInt64);
  # Stores the size of each variable attribute file.

  fragmentUri @17 :Text;
  # The uri of the fragment the metadata belongs to.

  lastTileCellNum @18 :UInt64;
  # Number of cells in the last tile (meaningful only in the sparse case).

  mbrs @19 :Void;
  # The MBRs (applicable only to the sparse case with irregular tiles).

  nextTileOffsets @20 :List(UInt64);
  # The offsets of the next tile for each attribute.

  nextTileVarOffsets @21 :List(UInt64);
  # The offsets of the next variable tile for each attribute.

  nonEmptyDomain @22 :DomainArray;
  # The non-empty domain in which the fragment is constrained. Note that the
  # type of the domain must be the same as the type of the array coordinates.

  tileIndexBase @23 :UInt64;
  # The tile index base which is added to tile indices in setter functions.
  # Only used in global order writes.

  tileOffsets @24 :List(List(UInt64));
  # The tile offsets in their corresponding attribute files. Meaningful only
  # when there is compression.

  tileVarOffsets @25 :List(List(UInt64));
  # The variable tile offsets in their corresponding attribute files.
  # Meaningful only for variable-sized tiles.

  tileVarSizes @26 :List(List(UInt64));
  # The sizes of the uncompressed variable tiles.
  # Meaningful only when there is compression for variable tiles.

  version @27 :UInt32;
  # The version of the library that created this metadata.

  timestamp @28 :UInt64;
  # timestamp array was opened
}

struct GlobalWriteState {
# state of global writes
    cellsWritten @0 :MapInt64;
    # Cells written so far in global write

    lastTiles @1 :Map(Text, List(Tile));
    # last tiles written to disk

    fragmentMetadata @2 :FragmentMetadata;
}

struct Tile {
# last tile written

    cellSize @0 :UInt64;
    # Size of cells for writting

    dimNum @1 :UInt32;
    # number of dimensions

    type @2 :Text;
    # datatype of tile

    buffer :union {
      int8 @3 :List(Int8);
      uint8 @4 :List(UInt8);
      int16 @5 :List(Int16);
      uint16 @6 :List(UInt16);
      int32 @7 :List(Int32);
      uint32 @8 :List(UInt32);
      int64 @9 :List(Int64);
      uint64 @10 :List(UInt64);
      float32 @11 :List(Float32);
      float64 @12 :List(Float64);
    }
    # buffer of data
}

struct Writer {
  # Write struct
  globalWriteState @0 :GlobalWriteState;

  checkCoordDups @1 :Bool;

  dedupCoords @2 :Bool;

  initialized @3 :Bool;

  fragmentUri @4 :Text;
}

struct ReadState {

  initialized @0 :Bool;
  # True if the reader has been initialized.

  overflowed @1 :Bool;
  # `True` if the query produced results that could not fit in some buffer.

  curSubarrayPartition @2 :DomainArray;
  # The current subarray the query is constrained on.

  subarrayPartitions :union {
    int8 @3 :List(List(Int8));
    uint8 @4 :List(List(UInt8));
    int16 @5 :List(List(Int16));
    uint16 @6 :List(List(UInt16));
    int32 @7 :List(List(Int32));
    uint32 @8 :List(List(UInt32));
    int64 @9 :List(List(Int64));
    uint64 @10 :List(List(UInt64));
    float32 @11 :List(List(Float32));
    float64 @12 :List(List(Float64));
  }
  # A list of subarray partitions. The head of the list is the partition
  # to be split next.
}

struct QueryReader {
  # Read struct (can't be called reader due to class name conflict)

  fragmentMetadata @0 :List(FragmentMetadata);
  # The fragment metadata.

  readState @1 :ReadState;
  # To handle incomplete read queries.
}

struct Query {
    buffers @0 :Map(Text, AttributeBuffer);
    # map of buffers

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
