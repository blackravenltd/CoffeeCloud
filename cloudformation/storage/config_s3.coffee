module.exports =
  Name: 'Config S3 Storage'
  CloudFormation: (env,h) ->
    Resources:
      ConfigS3:
        Type: 'AWS::S3::Bucket'
        Properties: 
          # AccelerateConfiguration: 
            # AccelerateConfiguration
          # AccessControl: String
          # AnalyticsConfigurations: 
          #   - AnalyticsConfiguration
          # BucketEncryption: 
          #   BucketEncryption
          BucketName: "Test Env Config Bucket"
          # CorsConfiguration: 
          #   CorsConfiguration
          # InventoryConfigurations: 
          #   - InventoryConfiguration
          # LifecycleConfiguration: 
          #   LifecycleConfiguration
          # LoggingConfiguration: 
          #   LoggingConfiguration
          # MetricsConfigurations: 
          #   - MetricsConfiguration
          # NotificationConfiguration: 
          #   NotificationConfiguration
          # ObjectLockConfiguration: 
          #   ObjectLockConfiguration
          # ObjectLockEnabled: Boolean
          # PublicAccessBlockConfiguration: 
          #   PublicAccessBlockConfiguration
          # ReplicationConfiguration: 
          #   ReplicationConfiguration
          # Tags: 
          #   - Tag
          # VersioningConfiguration: 
          #   VersioningConfiguration
          # WebsiteConfiguration: 
          #   WebsiteConfiguration