# db/seeds.rb

# Limpa todos os produtos existentes
puts 'Limpando registros existentes...'
Machine.destroy_all
Product.destroy_all

MACHINE_TYPES = [
  { type: 'Injetora', capacity_range: (80..400), unit: 't' },
  { type: 'Prensa', capacity_range: (20..200), unit: 't' },
  { type: 'Torno CNC', capacity_range: (400..1500), unit: 'mm' },
  { type: 'Centro de Usinagem', capacity_range: (500..2000), unit: 'mm' },
  { type: 'Fresadora', capacity_range: (300..1200), unit: 'mm' },
  { type: 'Dobradeira', capacity_range: (50..300), unit: 't' }
]

puts 'Criando máquinas...'

# Criar 20 máquinas com dados realistas
20.times do |i|
  # Seleciona um tipo aleatório de máquina
  machine_type = MACHINE_TYPES.sample
  capacity = machine_type[:capacity_range].to_a.sample

  # Gera um código sequencial baseado no tipo
  code = "#{machine_type[:type][0..2]}#{(i + 1).to_s.rjust(3, '0')}"

  # Gera um nome descritivo
  name = "#{machine_type[:type]} #{capacity}#{machine_type[:unit]}"

  # Cria a máquina com status aleatório (mais ativos que inativos)
  Machine.create!(
    code: code,
    name: name,
    status: rand(10) < 8 ? :active : :inactive # 80% de chance de estar ativo
  )
end

# Imprime um resumo
puts "Criadas #{Machine.count} máquinas"
puts "Ativas: #{Machine.active.count}"
puts "Inativas: #{Machine.inactive.count}"

# Imprime algumas máquinas para verificação
puts "\nExemplos de máquinas criadas:"
Machine.limit(5).each do |machine|
  puts "#{machine.code} - #{machine.name} (#{machine.status})"
end

# Array de produtos para criar
products = [
  {
    code: 'PRD001',
    name: 'Peça A - Injeção',
    standard_time: 30.5,
    setup_time: 15.0,
    status: 'active'
  },
  {
    code: 'PRD002',
    name: 'Peça B - Montagem',
    standard_time: 45.2,
    setup_time: 20.0,
    status: 'active'
  },
  {
    code: 'PRD003',
    name: 'Peça C - Acabamento',
    standard_time: 15.8,
    setup_time: 10.0,
    status: 'inactive'
  },
  {
    code: 'PRD004',
    name: 'Peça D - Pintura',
    standard_time: 60.0,
    setup_time: 30.0,
    status: 'in_development'
  },
  {
    code: 'PRD005',
    name: 'Peça E - Usinagem',
    standard_time: 25.3,
    setup_time: 12.5,
    status: 'active'
  },
  {
    code: 'PRD006',
    name: 'Peça F - Corte',
    standard_time: 18.7,
    setup_time: 8.0,
    status: 'inactive'
  },
  {
    code: 'PRD007',
    name: 'Peça G - Dobra',
    standard_time: 22.4,
    setup_time: 11.0,
    status: 'active'
  },
  {
    code: 'PRD008',
    name: 'Peça H - Solda',
    standard_time: 35.6,
    setup_time: 25.0,
    status: 'in_development'
  },
  {
    code: 'PRD009',
    name: 'Peça I - Estampagem',
    standard_time: 28.9,
    setup_time: 18.0,
    status: 'active'
  },
  {
    code: 'PRD010',
    name: 'Peça J - Embalagem',
    standard_time: 12.3,
    setup_time: 5.0,
    status: 'active'
  },
  {
    code: 'PRD011',
    name: 'Peça K - Extrusão',
    standard_time: 40.1,
    setup_time: 22.0,
    status: 'inactive'
  },
  {
    code: 'PRD012',
    name: 'Peça L - Rotomoldagem',
    standard_time: 55.8,
    setup_time: 35.0,
    status: 'active'
  },
  {
    code: 'PRD013',
    name: 'Peça M - Termoformagem',
    standard_time: 42.7,
    setup_time: 28.0,
    status: 'in_development'
  },
  {
    code: 'PRD014',
    name: 'Peça N - Fundição',
    standard_time: 65.4,
    setup_time: 40.0,
    status: 'active'
  },
  {
    code: 'PRD015',
    name: 'Peça O - Fresagem',
    standard_time: 33.2,
    setup_time: 16.0,
    status: 'active'
  }
]

# Cria os produtos
products.each do |product_data|
  product = Product.create!(product_data)
  puts "Produto criado: #{product.code} - #{product.name}"
end

# Sumário
puts "\nResumo da criação:"
puts "Total de produtos criados: #{Product.count}"
puts "Produtos ativos: #{Product.where(status: 'active').count}"
puts "Produtos inativos: #{Product.where(status: 'inactive').count}"
puts "Produtos em desenvolvimento: #{Product.where(status: 'in_development').count}"
