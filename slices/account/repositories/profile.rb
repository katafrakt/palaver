class Account::Repositories::Profile < Palaver::Repository[:profiles]
  struct_namespace Account::Entities
  commands :create
end
