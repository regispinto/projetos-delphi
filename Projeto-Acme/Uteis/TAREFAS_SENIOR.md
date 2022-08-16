- [VISUAL] Fazer com que o software abra já maximizado; --> CONCLUIDO

- [VISUAL] Criar uma tela splash; --> CONCLUIDO

- [VISUAL] Criar um rodapé com alguns dados fictícios do usuário e, principalmente, um relógio com a data e hora atualizando constantemente; --> CONCLUIDO

- [VISUAL] Colocar um logotipo no cabeçalho; --> CONCLUIDO

- [VISUAL] Acertar a ordem de tabulação do Cadastro de Cliente; --> CONCLUIDO

- [VISUAL] No cadastro de cliente definir máscaras adequadas para os campos: --> CONCLUIDO
  - NASCIMENTO --> CONCLUIDO
  - TELEFONE --> CONCLUIDO
  - INSCRIÇÃO FISCAL (Perceba que é o mesmo campo para CNPJ e CPF) --> CONCLUIDO

- [DATABASE] - Na tela de Cadastro de Cliente faltam criar as funcionalidades de EXCLUIR e EDITAR bem como informar, no rodapé, --> CONCLUIDO
			   o número do registro atual versus a quantidade de registros (exemplo: `Cliente 1 de 60`) --> CONCLUIDO
			   
			Considerações:
			--------------
			Inseri os DbEdits dentro de um TPanel com a Enabled=False, para proteger a manutenção "acidental" por parte dos usuários
			   
- [RECURSOS] Criar arquivo de configuração, INI, para as informações de acesso ao banco de dados; --> CONCLUIDO

- [REGEX] Ainda na tela de Cadastro de Cliente acertar a RegEx para aceitar outros endereços de email que terminem 	--> Falta implementar <--
         com `.com` e `.com.br` - hoje só aceita `.com.br` (Isto é uma regra de negócio explícita) 																	

- [RECURSOS] Mover os componentes não visuais para um `DataModule`; --> CONCLUIDO

- [SQL]  Na tela de Cadastro de Clientes tornar o ID auto incremental, ou seja, fazer com que o usuário não precise digitar o ID --> CONCLUIDO

		Considerações:
		--------------
		Implementei uma function no DataModule para incrementar um Generator qualquer, quando da inclusão de um novo registro
		Também implementei nos forms fCadCliente e fCadUsuario, no botão Cancelar um descremento do Generator, caso o 
		usuário cancele a inclusão do registro.
		
- [PASCAL] Na tela de Cadastro de Clientes criar a funcionalidade de exportação dos registros para CSV; --> CONCLUIDO

- [PASCAL] Na tela de Listagem de Arquivos é listado os arquivos XML presentes em um determinado diretório. 
           É necessário melhorar a rotina para listar os arquivos presentes em eventuais sub-diretórios;			--> Faltou implementar <--

- [PASCAL] - Há vazamentos de memória que precisam ser eliminados; --> CONCLUIDO	

- [PASCAL] - Na tela de Cadastro de Clientes o `OnValidate` do campo `INSCRICAO_FISCAL` está fazendo uso de duas classes para validar o CNPJ e o CPF. 
             Pede-se implementar estas rotinas na unit `InscricaoFiscal.pas`.  --> CONCLUIDO

		    Considerações:
			--------------
			Mudei o tipo de retorno de TCNPJ e TCPF de boolean para string pois aproveito ambas para setar uma mensagem de retorno
			em caso de informação inválida. No OnValidade, se o retorno for diferente de EmptyStr, apenas mostro a mensagem.

- [HTTP] - Na tela de Cadastro de Cliente criar a funcionalidade de preencher o endereço à partir do CEP informado;	--> Faltou implementar <--
	     - Dê preferência para o formato XML usando o serviço web da ViaCEP - https://viacep.com.br/		
		 

- [EMAIL] - Ainda na tela de Cadastro de Cliente criar a funcionalidade de enviar email;							--> Faltou implementar <--
          - A ideia é abrir uma tela para escrever um texto arbitrário e enviar ao email do cliente em questão. 

- [DATABASE] Nova tela de Cadastro de Usuários:
  - CRUD completo com as mesmas funcionalidades da tela de Cadastro de Cliente; --> CONCLUIDO
  - Criar tabela `USUARIOS` com os campos:
    - `ID_USUARIO`
    - `NOME`
    - `LOGIN`
    - `SENHA`
    - `ATIVO`
	
			Considerações:
			--------------
			Inseri os DbEdits dentro de um TPanel com a Enabled=False, para proteger a manutenção "acidental" por parte dos usuários
			Coloquei um TSpeedButton para o usuário poder visualisar a senha informada
			Na unit uFuncoes, criei um record para guardar o idusuario e nome do usuário de login para utilizar em outros momentos no sistema
			No fMain, envento OnShow, aproveito para mostrar no TSatutaBar, panel[0], o usário logado

- [DATABASE] Adequar o Cadastro de Cliente para que registre o ID do usuário que efetuou a operação de INCUSÃO dos registros; --> CONCLUIDO
		    
			Considerações:
			--------------
			Coloquei um TLabel no fCadCliente mostrando que foi o usuário responsável pela inclusão de cada registro
			Implementei no botão 'Gravar' o ID_USARIO, utilizando a informação do record DadosUsuario.IdUsuario, responsável pela inclusão do cliente

- [DELPHI] Criar uma tela de login para acessar o aplicativo; --> CONCLUIDO	
			Considerações:
			--------------
			Coloquei um TSpeedButton para o usuário poder visualisar a senha informada
			Na unit uFuncoes, criei um record para guardar o idusuario e nome do usuário de login para utilizar em outros momentos no sistema
			No fMain, envento OnShow, aproveito para mostrar no TSatusBar, panel[0], o usário logado

- [PASCAL] A solução de validação de CNPJ e CPF se baseou em uma classe abstrata e duas classes concretas.  		--> Faltou implementar <--
           Pede-se para mudar a abordagem para utilizar `Interface` no lugar da classe abstrata.			

- [PASCAL] Fazer com que só seja possível executar uma instância do executável --> CONCLUIDO