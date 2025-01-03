# JAYSettings-Delphi

JAYSettings-Delphi é uma biblioteca para gerenciar arquivos de configuração baseados em JSON de forma simples e eficiente em aplicações Delphi.

## 🚀 Recursos
- Carregamento e salvamento automático de configurações em JSON.
- Suporte a tipos de dados primitivos (string, integer, boolean, float).
- Facilidade na manipulação de configurações com métodos intuitivos.
- Persistência de configurações entre execuções do programa.

## 📂 Estrutura do Projeto
```
/JAYSettings-Delphi
  ├── src/                # Código-fonte principal
  │   ├── JAYSettings.pas # Classe principal de gerenciamento de configurações
  │   ├── JSONHelper.pas  # Métodos auxiliares para manipulação de JSON
  │   └── Interfaces/     # Interfaces do sistema
  ├── examples/           # Exemplos de uso
  ├── tests/              # Testes unitários
  ├── README.md           # Documentação do projeto
  ├── LICENSE             # Licença do projeto
  └── JAYSettings.dproj   # Arquivo do projeto Delphi
```

## 📌 Instalação
1. Clone o repositório:
   ```sh
   git clone https://github.com/DevHenriGama/JAYSettings-Delphi.git
   ```
2. Adicione a pasta `src/` ao seu **Library Path** no Delphi.
3. Comece a usar a biblioteca em seu projeto!

### 📦 Instalação via Boss
Se você utiliza o **Boss**, pode instalar a biblioteca com o seguinte comando:
```sh
boss install https://github.com/DevHenriGama/JAYSettings-Delphi.git
```

## 🛠️ Como Usar
```delphi
uses
  JAYSettings;

var
  Config: TJAYSettings;
begin
  Config := TJAYSettings.Create('config.json');
  try
    // Definir uma configuração
    Config.SetValue('App.Theme', 'Dark');
    Config.SetValue('App.Volume', 75);
    
    // Obter um valor
    ShowMessage(Config.GetValue<string>('App.Theme'));
    ShowMessage(IntToStr(Config.GetValue<Integer>('App.Volume')));
  finally
    Config.Free;
  end;
end;
```

## 📝 Licença
Este projeto é licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📢 Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir **issues** e **pull requests**.

---

Desenvolvido com ❤️ para a comunidade Delphi!

