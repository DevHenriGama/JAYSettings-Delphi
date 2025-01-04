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
  │   ├── JaySettings.CORE.pas # Classe principal de gerenciamento de configurações
  │   ├── JaySettings.Interfaces.pas  # Interfaces do projeto
  ├── examples/           # Exemplos de uso
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
  JaySettings.CORE;

//Para Ler uma configuração
procedure ReadConfig;
begin
  if not Settings.ContainsKey(Edit1.Text) then
  begin
    ShowMessage('Não possui essa configuração salva');
    Exit;
  end;

  //Checkbox define se usa criptografia
  Edit2.Text := Settings(CheckBox1.Checked).GetSettings(Edit1.Text);
end;

//Para Salvar uma configuração
procedure WriteConfig;
begin
  Settings(CheckBox1.Checked).SetSettings(Edit1.Text, Edit2.Text);
end;

```

## 📝 Licença
Este projeto é licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📢 Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir **issues** e **pull requests**.

---

Desenvolvido com ❤️ para a comunidade Delphi!

