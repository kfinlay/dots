cask 'expandrive' do
  version '4.3.2'
  sha256 'a3e2bfa0ce25462b27ad2d8daffbc6a79a098cda44030451b79585366ac6cbc4'

  url "https://updates.expandrive.com/apps/expandrive/v/#{version.dots_to_hyphens}/download.dmg"
  name 'ExpanDrive'
  homepage 'http://updates.expandrive.com/release_notes/expandrive'

  app 'ExpanDrive.app'

end
