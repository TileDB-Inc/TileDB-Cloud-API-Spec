@0xb57d9224b587d87f;

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

    coordsCompression @4 :Text;
    # Type of compression for coordinates (enum)

    coordsCompressionLevel @5 :Int32;
    # Level of coordinates compression

    domain @6 :Domain;
    # Domain of array

    offsetCompression @7 :Text;
    # Compression type of cell variable offsets (enum)

    offsetCompressionLevel @8 :Int32;
    # Compression level for cell variable offsets

    tileOrder @9 :Text;
    # Tile order setting of array

    uri @10 :Text;
    # URI of schema

    version @11 :List(Int32);
    # file format version
}

struct Attribute {
# Attribute of array
    cellValNum @0 :UInt32;
    # Attribute number of values per cell

    compressor @1 :Text;
    # Compressor type used for attribute compression (enum)

    compressorLevel @2 :Int32;
    # Level setting for compression

    name @3 :Text;
    # Attribute name

    type @4 :Text;
    # TileDB attribute datatype
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

    domain :union {
      int8 @13 :List(Int8);
      uint8 @14 :List(UInt8);
      int16 @15 :List(Int16);
      uint16 @16 :List(UInt16);
      int32 @17 :List(Int32);
      uint32 @18 :List(UInt32);
      int64 @19 :List(Int64);
      uint64 @20 :List(UInt64);
      float32 @21 :List(Float32);
      float64 @22 :List(Float64);
    }
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

  domain :union {
    int8 @14 :List(Int8);
    uint8 @15 :List(UInt8);
    int16 @16 :List(Int16);
    uint16 @17 :List(UInt16);
    int32 @18 :List(Int32);
    uint32 @19 :List(UInt32);
    int64 @20 :List(Int64);
    uint64 @21 :List(UInt64);
    float32 @22 :List(Float32);
    float64 @23 :List(Float64);
  }
  # The (expanded) domain in which the fragment is constrained. "Expanded"
  # means that the domain is enlarged minimally to coincide with tile
  # boundaries (if there is a tile grid imposed by tile extents). Note that the
  # type of the domain must be the same as the type of the array coordinates.


  fileSizes @24 :List(UInt64);
  # Stores the size of each attribute file.

  fileVarSizes @25 :List(UInt64);
  # Stores the size of each variable attribute file.

  fragmentUri @26 :Text;
  # The uri of the fragment the metadata belongs to.

  lastTileCellNum @27 :UInt64;
  # Number of cells in the last tile (meaningful only in the sparse case).

  mbrs @28 :Void;
  # The MBRs (applicable only to the sparse case with irregular tiles).

  nextTileOffsets @29 :List(UInt64);
  # The offsets of the next tile for each attribute.

  nextTileVarOffsets @30 :List(UInt64);
  # The offsets of the next variable tile for each attribute.

  nonEmptyDomain :union {
    int8 @31 :List(Int8);
    uint8 @32 :List(UInt8);
    int16 @33 :List(Int16);
    uint16 @34 :List(UInt16);
    int32 @35 :List(Int32);
    uint32 @36 :List(UInt32);
    int64 @37 :List(Int64);
    uint64 @38 :List(UInt64);
    float32 @39 :List(Float32);
    float64 @40 :List(Float64);
  }
  # The non-empty domain in which the fragment is constrained. Note that the
  # type of the domain must be the same as the type of the array coordinates.

  tileIndexBase @41 :UInt64;
  # The tile index base which is added to tile indices in setter functions.
  # Only used in global order writes.

  tileOffsets @42 :List(List(UInt64));
  # The tile offsets in their corresponding attribute files. Meaningful only
  # when there is compression.

  tileVarOffsets @43 :List(List(UInt64));
  # The variable tile offsets in their corresponding attribute files.
  # Meaningful only for variable-sized tiles.

  tileVarSizes @44 :List(List(UInt64));
  # The sizes of the uncompressed variable tiles.
  # Meaningful only when there is compression for variable tiles.

  version @45 :List(Int32);
  # The version of the library that created this metadata.
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

    compressor @1 :Text;
    # Type of compression for buffer (enum)

    compressorLevel @2 :Int32;
    # Level of buffer compression

    # number of dimensions
    dimNum @3 :UInt32;

    # datatype of tile
    type @4 :Text;
    buffer :union {
      int8 @5 :List(Int8);
      uint8 @6 :List(UInt8);
      int16 @7 :List(Int16);
      uint16 @8 :List(UInt16);
      int32 @9 :List(Int32);
      uint32 @10 :List(UInt32);
      int64 @11 :List(Int64);
      uint64 @12 :List(UInt64);
      float32 @13 :List(Float32);
      float64 @14 :List(Float64);
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

  curSubarrayPartition :union {
    int8 @2 :List(Int8);
    uint8 @3 :List(UInt8);
    int16 @4 :List(Int16);
    uint16 @5 :List(UInt16);
    int32 @6 :List(Int32);
    uint32 @7 :List(UInt32);
    int64 @8 :List(Int64);
    uint64 @9 :List(UInt64);
    float32 @10 :List(Float32);
    float64 @11 :List(Float64);
  }
  # The current subarray the query is constrained on.

  subarrayPartitions :union {
    int8 @12 :List(List(Int8));
    uint8 @13 :List(List(UInt8));
    int16 @14 :List(List(Int16));
    uint16 @15 :List(List(UInt16));
    int32 @16 :List(List(Int32));
    uint32 @17 :List(List(UInt32));
    int64 @18 :List(List(Int64));
    uint64 @19 :List(List(UInt64));
    float32 @20 :List(List(Float32));
    float64 @21 :List(List(Float64));
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

    subarray :union {
      int8 @6 :List(Int8);
      uint8 @7 :List(UInt8);
      int16 @8 :List(Int16);
      uint16 @9 :List(UInt16);
      int32 @10 :List(Int32);
      uint32 @11 :List(UInt32);
      int64 @12 :List(Int64);
      uint64 @13 :List(UInt64);
      float32 @14 :List(Float32);
      float64 @15 :List(Float64);
    }
    # Limit dense operations to these dimensions
}
