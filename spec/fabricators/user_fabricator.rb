Fabricator(:user) do
  name "Fabricated User"
  provider 'twitter'
  uid {Fabricate.sequence(:uid)}
end
