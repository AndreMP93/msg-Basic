class AppStrings{
  static const appName = "msg Basic";

  static const emailLabel = "Email";
  static const passwordLabel = "Password";
  static const userNameLabel = "Nome";
  static const aboutLabel = "Recado";
  static const createAnAccountLabel = "Não tem conta? Cadastre-se aqui!";
  static const loginButton = "Entrar";
  static const registerButton = "Cadastrar";
  static const saveButton = "Salvar";
  static const cancelButton = "Cancelar";

  static const registerUserLabel = "Cadastro de Usuário";
  static const userProfileLabel = "Perfil de Usuário";

  static const menuItemProfile = "Perfil";
  static const menuItemLogout = "Sair";
  static const tabConversationsLabel = "Conversas";
  static const tabContactsLabel = "Contatos";

  static const editNameTitle = "Insira seu Nome";
  static const editAboutTitle = "Adicione um Recado";

  static const errorRequiredField = "Campo Obrigatorio!";
  static const errorInvalidEmail = "Endereço de email invalido!";
  static const errorInvalidPassword = "Sua senha dever ter no minimo 6 caracteres";
  static const passwordError = "Senha invalida, sua senha deve ter no mínimo 6 caracters.";
  static const emailError = "Endereço de email invalido.";
  static const userNameError = "Nome de usuario invalido.";
  static const errorNetworkRequestFailed = "Sem conexão a internet";
  static const errorGettingAdData = "Falha ao tentar recuperar dados do Anúncio";
  static const errorGettingUserData = "Falha ao tentar recuperar dados do Usuário";
  static const errorMaxLength100 = "Esse campo suporta apenas 100 caracteres";
  //error messages for user registration
  static const registerUserError = "Falha ao cadastrar o usuário! Tente novamente mais tarde.";
  static const registerErrorWeakPassword = "Temnte colocar uma senha que possua letra e números";
  static const registerErrorEmailAlreadyUse = "Já exite um usuário com esse endereço de email.";
  static const updateDataUserError = "Falhao ao atualizar os dados do usário!";
  static const registerAdError = "Falha ao cadastrar o seu Anúncio! Tente novamente mais tarde.";
  static const userLoggedOut = "Usuário deconectado, por favor faça o login.";

  //error messages for user login
  static const loginError = "Flha ao acessar a conta do usuário!";
  static const loginErrorInvalidEmail = "Endereço de email invalido";
  static const loginErrorUserNotFound = "Usuário não encontrado";
  static const loginErrorNetworkRequestFailed = "Sem conexão a internet";
  static const loginErrorWrongPassword = "Senha incorreta.";
  static const loginErrorTooManyRequests = "Muitas tentativas de login, tente novamente mais tarde";

  //error messages for logout
  static const logoutUserError = "Falha ao desconectar o usuário da sua conta";
  static const errorUpdateProfilePhoto = "Falha ao salvar a imagem no banco de dados";
}