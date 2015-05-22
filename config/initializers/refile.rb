require "refile/s3"

 Refile.host = "http://d1djl7kr085bc1.cloudfront.net/"

aws = {
 access_key_id: "AKIAJLFLP6QXQ5WP5CZQ",
 secret_access_key: "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",
 region: "Singapore",
 bucket: "fitnesspapav3",
}

Refile.store = Refile::S3.new(prefix: "store", **aws)
