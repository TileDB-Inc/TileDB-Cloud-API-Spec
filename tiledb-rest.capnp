@0xb57d9224b587d87f;

enum ArrayType {
    dense @0;
    sparse @1;
}

enum Compressor {
    noCompression @0;
    gzip @1;
    zstd @2;
    lz4 @3;
    bloscLZ @4;
    bloscLZ4 @5;
    bloscLZ4HC @6;
    bloscSnappy @7;
    bloscZlib @8;
    bloscZstd @9;
    rle @10;
    bzip2 @11;
    doubleDelta @12;
}

enum Datatype {
    int32 @0;
    int64 @1;
    float32 @2;
    float64 @3;
    char @4;
    int8 @5;
    uint8 @6;
    int16 @7;
    uint16 @8;
    uint32 @9;
    uint64 @10;
    stringAscii @11;
    stringUTF9 @12;
    stringUTF16 @13;
    stringUTF32 @14;
    stringUCS2 @15;
    stringUCS4 @16;
    any @17;
}

enum Layout {
    rowMajor @0;
    colMajor @1;
    globalOrder @2;
    unordered @3;
}

enum Querystatus {
    failed @0;
    completed @1;
    inprogress @2;
    incomplete @3;
    uninitialized @4;
}

enum Querytype {
    read @0;
    write @1;
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
      text @11 :Text;
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

struct MapInt64 {
  entries @0 :List(Entry);
  struct Entry {
    key @0 :Text;
    value @1 :Int64;
  }
}

struct GlobalWriteState {
# state of global writes
    cellsWritten @0 :MapInt64;
    # Cells written so far in global write

    lastTiles @1 :Map(Text, List(Tile));
    # last tiles written to disk
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
}

struct Query {
    arraySchema @0 :ArraySchema;
    # Array Schema query is running on

    buffers @1 :Map(Text, AttributeBuffer);
    # map of buffers

    layout @2 :Text;
    # query write layout

    status @3 :Text;
    # query status

    type @4 :Text;
    # Type of query

    writer @5 :Writer;
    # writer contains data needed for continuation of global write order queries

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
