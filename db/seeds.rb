# db/seeds.rb

# Limpa todos os registros existentes
puts 'Limpando registros existentes...'
MachineProduct.destroy_all
Machine.destroy_all
Product.destroy_all

MACHINE_TYPES = [
  { type: 'Injetora', capacity_range: (80..400), unit: 't' },
  { type: 'Prensa', capacity_range: (20..200), unit: 't' },
  { type: 'Torno CNC', capacity_range: (400..1500), unit: 'mm' },
  { type: 'Centro de Usinagem', capacity_range: (500..2000), unit: 'mm' },
  { type: 'Fresadora', capacity_range: (300..1200), unit: 'mm' }
]

puts 'Criando 10 máquinas...'
machines = []

# Criar 10 máquinas (2 de cada tipo)
MACHINE_TYPES.each do |machine_type|
  2.times do |i|
    capacity = machine_type[:capacity_range].to_a.sample
    index = machines.length + 1
    code = "#{machine_type[:type][0..2]}#{index.to_s.rjust(3, '0')}"
    name = "#{machine_type[:type]} #{capacity}#{machine_type[:unit]}"

    machine = Machine.create!(
      code: code,
      name: name,
      status: rand(10) < 8 ? :active : :inactive # 80% de chance de estar ativo
    )
    machines << machine
  end
end

puts "Criando 30 produtos..."

# Gerar nomes de produtos mais realistas para cada tipo de máquina
PRODUCT_NAMES = {
  'Injetora' => ['Carcaça', 'Tampa', 'Base', 'Suporte', 'Container', 'Gabinete'],
  'Prensa' => ['Chapa', 'Painel', 'Estrutura', 'Cobertura', 'Lateral', 'Base'],
  'Torno CNC' => ['Eixo', 'Pino', 'Bucha', 'Engrenagem', 'Rolamento', 'Polia'],
  'Centro de Usinagem' => ['Bloco', 'Matriz', 'Molde', 'Base Usinada', 'Suporte Precision', 'Guia'],
  'Fresadora' => ['Perfil', 'Canal', 'Rasgo', 'Encaixe', 'Ranhura', 'Chanfro']
}

# Criar 30 produtos
30.times do |i|
  # Escolhe um tipo de máquina aleatório
  machine_type = MACHINE_TYPES.sample
  # Pega um nome de produto específico para o tipo de máquina
  product_names = PRODUCT_NAMES[machine_type[:type]]
  base_name = product_names.sample

  product = Product.create!(
    code: "PRD#{(i + 1).to_s.rjust(3, '0')}",
    name: "#{base_name} #{machine_type[:type]} - #{rand(100..999)}",
    standard_time: rand(15.0..120.0).round(1),
    setup_time: rand(5.0..60.0).round(1),
    status: [:active, :active, :active, :inactive, :in_development].sample # 60% ativo, 20% inativo, 20% em desenvolvimento
  )

  # Vincula o produto a 1-3 máquinas do tipo apropriado
  machines_of_type = machines.select { |m| m.name.include?(machine_type[:type]) }
  machines_to_link = machines_of_type.sample(rand(1..2))

  machines_to_link.each do |machine|
    MachineProduct.create!(
      machine: machine,
      product: product
    )
  end
end

# Imprime um resumo
puts "\nResumo da criação:"
puts "Total de máquinas: #{Machine.count}"
puts "Máquinas ativas: #{Machine.active.count}"
puts "Máquinas inativas: #{Machine.inactive.count}"

puts "\nTotal de produtos: #{Product.count}"
puts "Produtos ativos: #{Product.where(status: 'active').count}"
puts "Produtos inativos: #{Product.where(status: 'inactive').count}"
puts "Produtos em desenvolvimento: #{Product.where(status: 'in_development').count}"

puts "\nVinculações produto-máquina: #{MachineProduct.count}"

# Mostra algumas máquinas e seus produtos
puts "\nExemplos de máquinas e seus produtos:"
Machine.limit(3).each do |machine|
  puts "\n#{machine.code} - #{machine.name} (#{machine.status})"
  machine.products.each do |product|
    puts "  - #{product.code}: #{product.name}"
  end
end

# db/seeds.rb
# ... [manter todo o código anterior até o resumo das máquinas e produtos]

puts "\nCriando planejamentos de produção..."

# Define os turnos e suas datas
SHIFTS = [
  { shift: :first_shift, date: Date.today },
  { shift: :second_shift, date: Date.today },
  { shift: :third_shift, date: Date.today },
  { shift: :first_shift, date: Date.tomorrow },
  { shift: :second_shift, date: Date.tomorrow },
  { shift: :third_shift, date: Date.tomorrow }
]

# Criar um planejamento para cada turno
SHIFTS.each do |shift_data|
  planning = ProductionPlanning.create!(
    planning_date: shift_data[:date],
    shift: shift_data[:shift]
  )

  # Seleciona 3-5 máquinas ativas aleatoriamente para cada planejamento
  machines_for_planning = Machine.active.sample(rand(3..5))

  machines_for_planning.each do |machine|
    # Pega 1-2 produtos ativos aleatórios desta máquina
    products = machine.products.where(status: :active).sample(rand(1..2))

    products.each do |product|
      ProductionPlanningItem.create!(
        production_planning: planning,
        machine: machine,
        product: product,
        goal: rand(10..50) # Meta entre 10 e 50 unidades
      )
    end
  end
end

# Adiciona o resumo dos planejamentos ao final
puts "\nResumo dos Planejamentos:"
puts "Total de planejamentos: #{ProductionPlanning.count}"
ProductionPlanning.all.each do |planning|
  puts "\nPlanejamento para #{planning.planning_date} - #{planning.shift}"
  puts "Quantidade de itens: #{planning.production_planning_items.count}"
  planning.production_planning_items.each do |item|
    puts "  - Máquina: #{item.machine.name}"
    puts "    Produto: #{item.product.name}"
    puts "    Meta: #{item.goal} unidades"
  end
end