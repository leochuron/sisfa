class Rol < ActiveRecord::Base
  # validations
  validates :nombre, presence: true, uniqueness: true

  # relationships
  has_many :user_rols, dependent: :destroy
  has_many :users, through: :user_rols

  # class methods:
  def self.administrador
    @@administrador ||= find_by nombre: "Administrador"
  end
  
  def self.enfermera
    @@alumno ||= find_by nombre: "Enfermera"
  end

  def self.vendedor
    @@vendedor ||= find_by nombre: "Vendedor"
  end

  def self.administrador_estadistica
    @@administrador_estadistica ||= find_by nombre: "Administrador_Estadística"
  end

  def self.administrador_farmacia
    @@administrador_farmacia ||= find_by nombre: "Administrador_Farmacia"
  end

  def self.administrador_enfermeria
    @@administrador_enfermeria ||= find_by nombre: "Administrador_Enfermería"
  end


end