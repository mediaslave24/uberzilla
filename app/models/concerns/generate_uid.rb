module GenerateUid
  CHARS = ('a'..'z').to_a.freeze

  def generate_uid
    [
      CHARS.shuffle[0..2].join,
      sprintf('%02x', rand(255)),
      CHARS.shuffle[0..2].join,
      sprintf('%02x', rand(255)),
      CHARS.shuffle[0..2].join
    ].join '-'
  end
end
