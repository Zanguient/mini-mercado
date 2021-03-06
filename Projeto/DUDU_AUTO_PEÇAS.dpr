program DUDU_AUTO_PE�AS;

uses
  Forms,
  SysUtils,
  RPDefine,
  uMenu in '..\Objetos\FrmMenu\uMenu.pas' {frmMenu},
  uFormBase in '..\Objetos\FrmBase\uFormBase.pas',
  uFechamento_Caixa in '..\Objetos\FrmCaixa\uFechamento_Caixa.pas' {frmFechamento_Caixa},
  UdmConexao in '..\Objetos\DataModule\DmConexao\UdmConexao.pas' {dmConexao: TDataModule},
  uDm in '..\Objetos\DataModule\DmDados\uDm.pas' {dm: TDataModule},
  uPDV in '..\Objetos\FrmPDV\uPDV.pas' {frmPDV},
  uAgenda in '..\Objetos\FrmAgenda\uAgenda.pas' {frmCadAgenda},
  uCad_Cliente in '..\Objetos\FrmCadCliente\uCad_Cliente.pas' {frmCadCliente},
  uCad_Fornecedor in '..\Objetos\FrmCadFornecedor\uCad_Fornecedor.pas' {frmCadFornecedor},
  uCad_Grupo in '..\Objetos\FrmCadGrupo\uCad_Grupo.pas' {frmCadGrupo},
  uCad_Produto in '..\Objetos\FrmCadProduto\uCad_Produto.pas' {frmCadProduto},
  uCad_Usuario in '..\Objetos\FrmCadUsuario\uCad_Usuario.pas' {frmCadUsuario},
  uCancela_Item in '..\Objetos\FrmCancela_Item\uCancela_Item.pas' {frmCancelaItem},
  uEntrada_Produtos in '..\Objetos\FrmEntrada_Produtos\uEntrada_Produtos.pas' {frmEntrada_Produtos},
  uForma_Pagamento in '..\Objetos\FrmForma_Pagamento\uForma_Pagamento.pas' {frmForma_Pagamento},
  uLogin in '..\Objetos\FrmLogin\uLogin.pas' {frmLogin},
  uOrcamento in '..\Objetos\FrmOr�amento\uOrcamento.pas' {frmOrcamento},
  uProcura_Cliente in '..\Objetos\FrmProcura_Cliente\uProcura_Cliente.pas' {frmProcura_Cliente},
  uProcura_Estoque in '..\Objetos\FrmProcura_Estoque\uProcura_Estoque.pas' {frmProcura_Estoque},
  uProcura_Fornecedor in '..\Objetos\FrmProcura_Fornecedor\uProcura_Fornecedor.pas' {frmProcura_Fornecedor},
  uProcura_Funcionario in '..\Objetos\FrmProcura_Funcionario\uProcura_Funcionario.pas' {frmProcura_Funcionario},
  uProcura_Grupo in '..\Objetos\FrmProcura_Grupo\uProcura_Grupo.pas' {frmProcura_Grupo},
  uProcura_Produto in '..\Objetos\FrmProcura_Produto\uProcura_Produto.pas' {frmProcura_Produto},
  uQtde in '..\Objetos\FrmQtde\uQtde.pas' {frmQtde},
  uRelatorio in '..\Objetos\FrmRelatorio\uRelatorio.pas' {frmRelatorio},
  uCalcula_Perc in '..\Objetos\FrmCalcula_Perc\uCalcula_Perc.pas' {frmCalula_Perc},
  uFuncao in '..\Objetos\Fun��es\uFuncao.pas',
  uVendas_Produto in '..\Objetos\FrmVendas_Produto\uVendas_Produto.pas' {frmVendas_Produto},
  uProcura_Venda in '..\Objetos\FrmProcura_Venda\uProcura_Venda.pas' {frmProcura_Venda},
  USobre in '..\Objetos\FrmSobre\USobre.pas' {frmSobre},
  USplash in '..\Objetos\FrmSplash\USplash.pas' {frmSplash},
  UConexao in '..\Objetos\Conexao\UConexao.pas';

{$R *.res}

begin
  RPDefine.DataID := IntToStr(Application.Handle);
  Application.Initialize;
  Application.Title := 'Sistema de Gest�o - Mini Mercado';
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmSplash, frmSplash);
  frmSplash.show;
  frmSplash.Refresh;
  Sleep(1000); // 2000 = 2 segundos
  frmSplash.Hide;
  frmSplash.Free;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
