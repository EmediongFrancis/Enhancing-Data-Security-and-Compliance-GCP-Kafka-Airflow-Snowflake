resource "aws_glue_catalog_database" "madhatter_glue_database" {
  name = "madhatter_glue_db"
}

resource "aws_glue_catalog_table" "madhatter_glue_table" {
  database_name = aws_glue_catalog_database.madhatter_glue_database.name
  name          = "madhatter_glue_table"

  storage_descriptor {
    columns {
      name = "column1"
      type = "string"
    }
    location      = "s3://${aws_s3_bucket.raw_data_bucket.bucket}/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "madhatter_glue_ser_de"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
    }
  }
}
