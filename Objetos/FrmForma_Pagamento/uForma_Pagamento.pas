unit uForma_Pagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uFormBase, ACBrBase, ACBrEnterTab;

type
  TfrmForma_Pagamento = class(TFormBase)
    pnl1: TPanel;
    lbl2: TLabel;
    grp1: TGroupBox;
    btnDinheiro: TBitBtn;
    btnCartao: TBitBtn;
    btnCheque: TBitBtn;
    grp2: TGroupBox;
    lbl1: TLabel;
    edtCliente: TEdit;
    lbl6: TLabel;
    btnCliente: TBitBtn;
    edtID: TEdit;
    btnFinalizar: TBitBtn;
    lblFormaPagamento: TLabel;
    grp3: TGroupBox;
    lbl3: TLabel;
    edtTotal: TEdit;
    lbl4: TLabel;
    edtDinheiro: TEdit;
    lbl5: TLabel;
    edtTroco: TEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    edtDesconto: TEdit;
    edtSubTotal: TEdit;
    ACBrEnterTab1: TACBrEnterTab;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure Dinheiro();
    procedure Cartao();
    procedure Cheque();
    procedure Finalizar();
    function Calcula(Total, valor: Double): Double;
    function CalculaDesconto(subTotal: Double; percent: Double): Double;
    procedure btnDinheiroClick(Sender: TObject);
    procedure btnCartaoClick(Sender: TObject);
    procedure btnChequeClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure edtDinheiroExit(Sender: TObject);
    procedure edtDescontoExit(Sender: TObject);
  private
    { Private declarations }
  public
    FResposta : boolean;
  end;

var
  frmForma_Pagamento: TfrmForma_Pagamento;

implementation

uses uDm, uPDV, uProcura_Cliente;

{$R *.dfm}

procedure TfrmForma_Pagamento.btnCartaoClick(Sender: TObject);
begin
     Cartao;
end;

procedure TfrmForma_Pagamento.btnChequeClick(Sender: TObject);
begin
     Cheque;
end;

procedure TfrmForma_Pagamento.btnClienteClick(Sender: TObject);
begin
     //Carrega o Form de pesquisa de cliente
     try
       frmProcura_Cliente := TfrmProcura_Cliente.Create(self);
       frmProcura_Cliente.ShowModal;
     finally
       FreeAndNil(frmProcura_Cliente);
     end;
end;

procedure TfrmForma_Pagamento.btnDinheiroClick(Sender: TObject);
begin
    Dinheiro;
end;

procedure TfrmForma_Pagamento.btnFinalizarClick(Sender: TObject);
begin
    Finalizar;
end;

function TfrmForma_Pagamento.Calcula(Total, valor: Double): Double;
begin
    //Fun��o para calcular o troco
    Result := 0;
    Result := Total - valor;
end;

function TfrmForma_Pagamento.CalculaDesconto(subTotal, percent: Double): Double;
var
   resultado: Double;
begin
     resultado := (subTotal * percent) / 100;
     resultado := subTotal - resultado;
     Result := resultado;
end;

procedure TfrmForma_Pagamento.Cartao;
begin
    //Procedure para carregar a forma de pagamento na vari�vel no formPDV
    frmPDV.iFTipo_Pagamento := 2;
    lblFormaPagamento.Caption := 'CART�O';
end;

procedure TfrmForma_Pagamento.Cheque;
begin
     //Procedure para carregar a forma de pagamento na vari�vel no formPDV
     frmPDV.iFTipo_Pagamento := 3;
     lblFormaPagamento.Caption := 'CHEQUE';
end;

procedure TfrmForma_Pagamento.Dinheiro;
begin
     //Procedure para carregar a forma de pagamento na vari�vel no formPDV
     frmPDV.iFTipo_Pagamento := 1;
     lblFormaPagamento.Caption := 'DINHEIRO';
end;

procedure TfrmForma_Pagamento.edtDescontoExit(Sender: TObject);
begin
    //Verifica se a tecla pressionada for ENTER e se o Edit Desconto cont�m valor
     if (edtDesconto.Text <> '') then
     begin
         edtTotal.Text := FormatFloat('##0.00', CalculaDesconto(StrToFloat(edtSubTotal.Text), StrToFloat(edtDesconto.Text)));
     end;
end;

procedure TfrmForma_Pagamento.edtDinheiroExit(Sender: TObject);
begin
     //Verifica se a tecla pressionada for ENTER e se o Edit Dinheiro cont�m valor
     if (edtDinheiro.Text <> '') then
     begin
         edtTroco.Text := FormatFloat('##0.00', Calcula(StrToFloat(edtDinheiro.Text), StrToFloat(edtTotal.Text)));
     end;
end;

procedure TfrmForma_Pagamento.Finalizar();
begin
     //Procedimento que finaliza as fun��es da tela e volta para o procedimento do FormPDV

     //Verifica se foi informado uma op��o de pagamento e se o ID do funcion�rio foi informado
     if (frmPDV.iFTipo_Pagamento > 0) and (edtID.Text <> '') then
     begin
         FrmPDV.sFID_Funcionario := edtID.Text;
         frmPDV.sFCod_cli        := edtCliente.Text;
         frmPDV.dFSub_total      := StrToFloat(edtSubTotal.Text);
         frmPDV.dFDesconto       := StrToFloat(edtDesconto.Text);
         frmPDV.dFTotal          := StrToFloat(edtTotal.Text);
         frmPDV.bFResposta := true;
         frmForma_Pagamento.Close;
     end
     else
     begin
         if (frmPDV.iFTipo_Pagamento = 0) then
         begin
             Application.MessageBox('Informe a forma de Pagamento!', 'Erro', MB_OK);
             Abort;
         end
         else
             if (edtID.Text = '') then
             begin
                Application.MessageBox('Informe o ID do funcion�rio!', 'Erro', MB_OK);
                Abort;
             end;
     end;
end;

procedure TfrmForma_Pagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action             := caFree;
     frmForma_Pagamento := nil;
end;

procedure TfrmForma_Pagamento.FormCreate(Sender: TObject);
begin
    //Carrega os valores na tela
    edtCliente.Text  := frmPDV.lblCod_Cli.Caption;
    edtID.Text       := frmPDV.sFID_Funcionario;
    edtSubTotal.Text := frmPDV.edtTotal.Text;
    edtTotal.Text    := frmPDV.edtTotal.Text;
    edtDesconto.Text := FormatFloat('##0.00', frmPDV.dFDesconto);
end;

procedure TfrmForma_Pagamento.KeyDown(var Key: Word; Shift: TShiftState);
begin
    if Key = VK_F1     then Dinheiro;
    if key = VK_F2     then Cartao;
    if Key = VK_F3     then Cheque;

    if Key = VK_F5 then
    begin
        Finalizar;
    end;

    if Key = VK_F7 then
    begin
        btnCliente.Click;
    end;

    if Key = VK_ESCAPE then
    begin
        frmForma_Pagamento.Close;
        frmPDV.bFResposta := false;
    end;

    if key = VK_RETURN then

end;

end.
