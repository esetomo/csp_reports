Sequel.migration do
  change do
    create_table(:csp_reports) do
      primary_key :id
      String :document_uri
      String :blocked_uri
      String :violated_directive
      String :original_policy
      Integer :report_count
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
