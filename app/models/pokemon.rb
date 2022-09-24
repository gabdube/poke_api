# == Schema Information
#
# Table name: pokemons
# t.string :name
# t.string :type_1
# t.string :type_2
# t.integer :stats_total
# t.integer :hp
# t.integer :attack
# t.integer :defense
# t.integer :sp_attack
# t.integer :sp_defense
# t.integer :speed
# t.integer :generation
# t.boolean :legendary
class Pokemon < ApplicationRecord
    validates :name, presence: true
    validates_uniqueness_of :name

    validates :type_1, presence: true
    validates :hp, presence: true, numericality: { greater_than: 0 }
    validates :attack, presence: true, numericality: { greater_than: 0 }
    validates :defense, presence: true, numericality: { greater_than: 0 }
    validates :sp_attack, presence: true, numericality: { greater_than: 0 }
    validates :sp_defense, presence: true, numericality: { greater_than: 0 }
    validates :speed, presence: true, numericality: { greater_than: 0 }
    validates :generation, presence: true, numericality: { greater_than: 0 }

    before_save do
        self.legendary = false if self.legendary.nil?
        self.stats_total = self.hp + self.attack + self.defense + self.sp_attack + self.sp_defense + self.speed
    end

end
