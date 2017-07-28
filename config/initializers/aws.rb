Aws.config.update(
    region: 'us-east-1',
    :access_key_id => 'AKIAJ2PZZD6QD6OBBYDQ',
    :secret_access_key => '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'
)


s3 = Aws::S3::Client.new
resource = Aws::S3::Resource.new(client: s3)
# reference an existing bucket by name
S3_BUCKET = resource.bucket('ensight2016')

#S3_BUCKET =  Aws::S3.new.buckets['gorgo']