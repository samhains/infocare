%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["test/", "web/", "lib/"],
        excluded: ["web/mapper.ex"]
      },
      checks: [
        {Credo.Check.Consistency.TabsOrSpaces}
      ]
    }
  ]
}
