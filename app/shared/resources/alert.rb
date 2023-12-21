class Alert < Jets::Stack
  sns_topic(:delivery_completed, display_name: "delivery completed")
end
