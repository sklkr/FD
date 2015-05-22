require "refile/backend/s3"

 Refile.host = "http://fitnesspapa.com"

aws = {
 access_key_id: "AKIAJLFLP6QXQ5WP5CZQ",
 secret_access_key: "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",
 bucket: "fitnesspapav3",
}

Refile.store = Refile::Backend::S3.new(prefix: "store", **aws)
