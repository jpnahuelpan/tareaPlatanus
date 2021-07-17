# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "tereaPlatanus"
  spec.version       = '1.0'
  spec.authors       = ["Juan Pablo Nahuelpán"]
  spec.email         = ["juanpablonahuelpan@gmail.com"]
  spec.summary       = %q{Tarea para puesto trainee en Platanus.}
  spec.description   = %q{Es una tarea preliminar, la cual si cumple las intrucciones
                          será sometida a evaluación, en caso que sea exitosa, se pasa
                          a la siguiente fase en que ocurre una entrevista técnica.}
  spec.homepage      = "https://github.com/jpnahuelpan/tareaPlatanus"
  #spec.license       = "MIT"

  spec.files         = ['lib/tareaPlatanus.rb']
  spec.executables   = ['bin/app.rb']
  spec.test_files    = ['tests/test_tareaPlatanus.rb']
  spec.require_paths = ["lib"]
end
