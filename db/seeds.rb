OrderItem.destroy_all
Order.destroy_all
Customer.destroy_all
Product.destroy_all
Category.destroy_all
Province.destroy_all
AdminUser.destroy_all

AdminUser.create!(
  email: "admin@prairienorth.ca",
  password: "password123",
  password_confirmation: "password123"
)

provinces = [
  { name: "Alberta", code: "AB", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "British Columbia", code: "BC", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "Manitoba", code: "MB", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "New Brunswick", code: "NB", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Newfoundland and Labrador", code: "NL", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Northwest Territories", code: "NT", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Nova Scotia", code: "NS", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Nunavut", code: "NU", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Ontario", code: "ON", gst: 0.00, pst: 0.00, hst: 0.13 },
  { name: "Prince Edward Island", code: "PE", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Quebec", code: "QC", gst: 0.05, pst: 0.09975, hst: 0.00 },
  { name: "Saskatchewan", code: "SK", gst: 0.05, pst: 0.06, hst: 0.00 },
  { name: "Yukon", code: "YT", gst: 0.05, pst: 0.00, hst: 0.00 }
]
provinces.each { |p| Province.create!(p) }

catalog = {
  "Board Games" => {
    desc: "Strategic tabletop board games for families, hobbyists, and competitive play.",
    titles: [
      "Catan: Settlers Edition", "Ticket to Ride: Canada", "Wingspan Core Box", "Terraforming Mars",
      "Azul: Stained Glass", "Carcassonne Big Box", "7 Wonders Duel", "Pandemic Legacy",
      "Root: Woodland Warfare", "Scythe Collector Edition", "Splendor Gem Trading", "Dominion Intrigue",
      "Everdell Woodland City", "Gloomhaven: Jaws of the Lion", "Cascadia Pacific Northwest",
      "Brass: Birmingham", "Dune: Imperium", "Ark Nova Zoo Builder", "Spirit Island",
      "Viticulture Essential", "Concordia Venus", "Betrayal at House on the Hill",
      "Codenames Party Edition", "King of Tokyo", "Agricola Revised", "Puerto Rico Classic"
    ]
  },
  "Miniatures" => {
    desc: "Detailed unpainted tabletop figurines, terrain kits, and acrylic hobby paints.",
    titles: [
      "Red Dragon Ancient Miniature", "Elven Ranger Warband", "Dwarven Forge Stone Tavern",
      "Space Marine Tactical Squad", "Clockwork Golem Boss Figure", "Necromancer Lich Set",
      "Medieval Castle Gate Terrain", "Griffon Rider Cavalry", "Cyberpunk Street Mercenaries",
      "Frost Giant Warlord", "Orc Berserker Regiment", "Steampunk Airship Model",
      "Forest Dryad & Treant Pack", "Paladin Knight Duelists", "Cthulhu Elder Spawn",
      "Goblin Ambush Diorama", "Vampire Lord Court", "Celestial Angel Guardian",
      "Dungeoneer Hero Starter Kit", "Skeletal Legion 12-Pack", "Arcane Crystal Obelisks",
      "Tavern Furniture Resin Set", "Werewolf Pack Alpha", "Mecha Assault Walker",
      "Swamp Hydra Miniature", "Artisan Wet Palette & Brush Kit"
    ]
  },
  "Trading Cards" => {
    desc: "Booster packs, commander decks, card sleeves, and collector deck boxes.",
    titles: [
      "Magic: Commander Masters Deck", "Pokemon: Scarlet & Violet Booster Box", "Lorcana: Into the Inklands",
      "Yu-Gi-Oh! 25th Anniversary Tin", "Flesh and Blood Blitz Deck", "One Piece Paramount War Pack",
      "Dragon Shield Matte Black Sleeves", "Ultra Pro Satin Tower Deck Box", "Star Wars Unlimited Starter",
      "Digimon Blast Ace Booster", "Weiss Schwarz Anime Trial Deck", "KeyForge Winds of Exchange",
      "Magic: Modern Horizons Bundle", "Pokemon Elite Trainer Box", "BCW 3200-Count Card Storage Box",
      "Magnetic One-Touch Card Holders", "Side-Loading 9-Pocket Binder", "Neoprene Stitched Playmat",
      "Aluminum Dice & Counter Case", "Arcane Tinmen Board Game Sleeves", "Final Fantasy TCG Opus Pack",
      "Cardfight Vanguard OverDress", "Sorcery: Contested Realm Box", "Altered TCG Kickstarter Deck",
      "KMC Perfect Fit Inner Sleeves", "Metallic Polyhedral Spin-Down Set"
    ]
  },
  "Artisan Puzzles" => {
    desc: "Handcrafted wooden jigsaw puzzles and Manitoba-inspired artist illustrations.",
    titles: [
      "Winnipeg Exchange District Twilight 1000pc", "Northern Lights Over Churchill 500pc",
      "Hand-Cut Maple Wolf Wooden Puzzle", "Bison on the Prairie 1000pc", "Assiniboine Park Autumn 750pc",
      "Whimsical Owl Laser-Cut Wood Puzzle", "Lake Winnipeg Lighthouse 1000pc", "Geometric Mandala Wooden Box",
      "Canadian Rockies Moraine Lake 1500pc", "Vintage Board Game Collage 1000pc",
      "Celestial Dragon Wooden Jigsaw", "Riding Mountain Pine Forest 500pc", "Artisan Fox Silhouette Puzzle",
      "Red River Steamship Heritage 1000pc", "Steampunk Clockwork Heart Wood Puzzle",
      "Prairie Sunflower Sunset 750pc", "Polar Bear & Cubs Arctic 1000pc", "Celtic Knot Hardwood Puzzle",
      "St. Boniface Cathedral Winter 500pc", "Fantasy World Map 2000pc", "Hummingbird Floral Wood Cut",
      "Gimli Harbour Sailboats 1000pc", "Mystic Forest Stag Wooden Puzzle", "Bookshelf Curiosities 1000pc",
      "Whiteshell Provincial Park Canoe 750pc", "Artisan Roll-Up Felt Puzzle Mat"
    ]
  }
}

catalog.each do |cat_name, data|
  category = Category.create!(name: cat_name, description: data[:desc])
  data[:titles].each_with_index do |title, idx|
    Product.create!(
      category: category,
      title: title,
      description: "#{title} — authentic #{cat_name.downcase} item stocked at Prairie North Board Game & Hobby Emporium in Winnipeg.",
      price: (14.99 + (idx * 3.50)).round(2),
      stock_quantity: 5 + (idx % 20)
    )
  end
end
Page.find_or_create_by!(slug: 'about') do |p|
  p.title = 'About Prairie North Board Game & Hobby Emporium'
  p.content = 'Operating in Winnipeg Exchange District for 8 years, Prairie North Board Game & Hobby Emporium offers specialty board games, tabletop miniatures, trading card games, and handmade puzzles from local Manitoba artisans.'
end
Page.find_or_create_by!(slug: 'contact') do |p|
  p.title = 'Contact Us'
  p.content = 'Visit our store in the Exchange District, Winnipeg, MB, or reach our customer service team at support@prairienorth.ca or (204) 555-0148.'
end
puts "Seeded #{Province.count} provinces, #{Category.count} categories, and #{Product.count} products."