unit uProcura_Estoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids, ExtCtrls, uPDV, DB, uQtde, MidasLib,
  ComCtrls, SqlExpr;

type
  TfrmProcura_Estoque = class(TForm)
    pnlTitulo: TPanel;
    pnlFiltros: TPanel;
    grdEstoque: TDBGrid;
    pnlRodape: TPanel;
    Label4: TLabel;
    lbl5: TLabel;
    edtCodigo: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CarregaConsulta();
    procedure CarregaItensOrcamento();
    procedure CarregaItensVenda();
    procedure grdEstoqueDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rgOpcaoClick(Sender: TObject);
    procedure grdEstoqueTitleClick(Column: TColumn);
    procedure ConsultaUniversal();
    procedure ConsultaUniversalChange(Sender: TObject);
    procedure Enter(Sender: TObject; var Key: Char);
    procedure grdEstoqueDblClick(Sender: TObject);
    procedure grdEstoqueKeyPress(Sender: TObject; var Key: Char);
    function GeraID: integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcura_Estoque: TfrmProcura_Estoque;

const
    //Cl�usula select para limpar itens pesquisados
    SELECT_ITEM : string = 'SELECT * FROM ITEM_VENDA WHERE ID=0';

    //Cl�usula select universal usada em todas as consultas
    SELECT : string = 'SELECT ET.EAN13, E.TIPO_ENTRADA, P.DESC_PROD, G.DESC_GRUPO, E.QTDE, P.ESTOQUE_MINIMO, P.UND, E.VAL_CUSTO, E.VAL_VENDA, P.APLICACAO ';

    // Cl�usula from para INNER JOIN entre as tabelas
    FROM : string = 'FROM ESTOQUE E LEFT JOIN PRODUTO P ON E.COD_PROD = P.COD_PROD INNER JOIN GRUPO G ON E.COD_GRUPO = G.COD_GRUPO INNER JOIN ENTRADA_PRODUTO ET ON E.COD_PROD = ET.COD_PROD';

implementation

uses uDm, uOrcamento, uRelatorio, UdmConexao;

{$R *.dfm}

function TfrmProcura_Estoque.GeraID: integer;
var
   qryID: TSQLQuery;
begin

    //Fun��o para capturar o ID gerado na procedure do banco de dados
    try
        try
            qryID := TSQLQuery.Create(nil);
            qryID.SQLConnection := dmConexao.Conexao;

            qryID.Close;
            qryID.SQL.Clear;
            qryID.SQL.Add('SELECT gen_id(gen_item_orcamento_id,1) FROM RDB$DATABASE');
            qryID.Open;

            Result := qryID.Fields[0].AsInteger;
        except
            on E:Exception do
            begin
                ShowMessage('Erro gerar C�digo do Or�amento!'#13#10 + E.Message);
                Result := 0;
            end;
        end;
    finally
        FreeAndNil(qryID);
    end;
end;

procedure TfrmProcura_Estoque.Enter(Sender: TObject; var Key: Char);
begin
    //Simula o TAB para trocar de campos
    if key = #13 then
    begin
        key := #0;
        SelectNext(ActiveControl, true, true);
    end;
end;

procedure TfrmProcura_Estoque.CarregaItensOrcamento;
begin
     //Procedimento para carregar os itens na ClientDataSet de itens de or�amento
     dm.cdsItem_Orc.Open;

     //Cria um �ndice para ordenar pelo campo ID
     dm.cdsItem_Orc.IndexFieldNames := 'ID';

     //Verifica se o item existe, caso n�o exista inseri um novo registro
     if not dm.cdsItem_Orc.Locate('REF_PROD', dm.cdsEstoque.FieldByName('REF_PROD').AsString, [loCaseInsensitive, loPartialKey]) then
     begin
        //Carrega valores no cds Itens do Or�amento
        dm.cdsOrcamento.Open;
        dm.cdsItem_Orc.Append;
        dm.cdsItem_Orc.FieldByName('ID').AsInteger            := GeraID;
        dm.cdsItem_Orc.FieldByName('COD_ORC').AsString        := frmOrcamento.edtNumero.Text;
        dm.cdsItem_Orc.FieldByName('DESC_PROD').AsString      := dm.cdsEstoque.FieldByName('DESC_PROD').AsString;
        dm.cdsItem_Orc.FieldByName('VAL_PROD').AsString       := dm.cdsEstoque.FieldByName('VAL_VENDA').AsString;
        dm.cdsItem_Orc.FieldByName('TIPO_ENTRADA').AsString   := dm.cdsEstoque.FieldByName('TIPO_ENTRADA').AsString;
        dm.cdsItem_Orc.FieldByName('TIPO_ORCAMENTO').AsString := frmOrcamento.cmbTipo.Text;
        frmOrcamento.grdOrcamento.SelectedIndex := 3;
     end;
end;

procedure TfrmProcura_Estoque.CarregaConsulta();
begin
     //Carrega consulta inicial
     dm.qryEstoque.Close;
     dm.qryEstoque.SQL.Clear;
     dm.qryEstoque.SQL.Add(SELECT);
     dm.qryEstoque.SQL.Add(FROM);
     dm.qryEstoque.Open;
     dm.cdsEstoque.Open;
     dm.cdsEstoque.Refresh;
end;

procedure TfrmProcura_Estoque.CarregaItensVenda;
begin
     //Procedimento para carregar os itens na ClientDataSet de itens de venda
     dm.qryItem_Venda.close;
     dm.qryItem_Venda.SQL.Clear;
     dm.qryItem_Venda.SQL.Add(SELECT_ITEM);
     dm.qryItem_Venda.Open;

     dm.cdsItem_Venda.Open;

     //Cria um �ndice para ordenar pelo campo ID_ITEM
     dm.cdsItem_Venda.IndexFieldNames := 'ID_ITEM';

     //Verifica se o item existe, caso n�o exista inseri um novo registro
     if not dm.cdsItem_Venda.Locate('EAN13', dm.cdsEstoque.FieldByName('EAN13').AsString, [loCaseInsensitive, loPartialKey]) then
     begin
         dm.cdsItem_Venda.Append;
         dm.cdsItem_Venda.FieldByName('ID_ITEM').AsInteger     := dm.cdsItem_Venda.RecordCount + 1;
         dm.cdsItem_Venda.FieldByName('N_VENDA').AsString      := frmPDV.lblVenda.Caption;
         dm.cdsItem_Venda.FieldByName('EAN13').AsString     := dm.cdsEstoque.FieldByName('EAN13').AsString;
         dm.cdsItem_Venda.FieldByName('DESC_PROD').AsString    := dm.cdsEstoque.FieldByName('DESC_PROD').AsString;
         dm.cdsItem_Venda.FieldByName('TIPO_ENTRADA').AsString := dm.cdsEstoque.FieldByName('TIPO_ENTRADA').AsString;
         dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat      := dm.cdsEstoque.FieldByName('VAL_VENDA').AsFloat;
     end;
end;

procedure TfrmProcura_Estoque.ConsultaUniversal;
begin
      //Consulta universal para todos os par�metros
      dm.qryEstoque.Close;
      dm.qryEstoque.SQL.Clear;
      dm.qryEstoque.SQL.Add(SELECT);
      dm.qryEstoque.SQL.Add(FROM);

      if edtCodigo.Text <> '' then
         dm.qryEstoque.SQL.Add('WHERE ET.EAN13 LIKE' + QuotedStr(edtCodigo.Text + '%') + 'OR P.DESC_PROD LIKE' + QuotedStr(edtCodigo.Text + '%'));

      dm.qryEstoque.Open;
      dm.cdsEstoque.Refresh;
end;

procedure TfrmProcura_Estoque.ConsultaUniversalChange(Sender: TObject);
begin
     //Evento que dispara � consulta para todos edts
     ConsultaUniversal();
end;

procedure TfrmProcura_Estoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    dm.cdsEstoque.Close;
    Action             := caFree;
    frmProcura_Estoque := nil;
end;

procedure TfrmProcura_Estoque.FormCreate(Sender: TObject);
begin
     dm.cdsEstoque.Open;
end;

procedure TfrmProcura_Estoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_ESCAPE then frmProcura_Estoque.Close;
     if Key = VK_F1     then
     begin
          CarregaConsulta();
     end;

     if Key = VK_F2     then
     begin
        CarregaConsulta();
     end;

     if Key = VK_F3     then
     begin
         CarregaConsulta();
     end;

     if Key = VK_F5     then
     begin
        try
           frmRelatorio := TfrmRelatorio.Create(self);
           frmRelatorio.GeraReport('Report_Estoque', 'RTEstoque.rav');
        finally
            FreeAndNil(frmRelatorio);
        end;
     end;

end;

procedure TfrmProcura_Estoque.grdEstoqueDblClick(Sender: TObject);
begin
    //Carrega os campos ap�s duplo clique sobre o registro
     if Assigned(frmOrcamento) then
     begin
         frmProcura_Estoque.Close;
         CarregaItensOrcamento();
     end;

     if Assigned(frmPDV) and (frmPDV.edtStatus.Text = 'Venda Aberta')then
     begin
         CarregaItensVenda();
         frmProcura_Estoque.Close;
         try
           frmQtde := TfrmQtde.Create(self);
           frmQtde.ShowModal;
         finally
           FreeAndNil(frmQtde);
         end;
     end;
end;

procedure TfrmProcura_Estoque.grdEstoqueDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    //Muda a cor da coluna estoque_minimo caso o valor esteja abaixo do estoque min�mo
    if dm.cdsEstoque.FieldByName('ESTOQUE_MINIMO').AsInteger > dm.cdsEstoque.FieldByName('QTDE').AsInteger then
    begin
        grdEstoque.Canvas.Brush.Color := clRed;
        grdEstoque.Canvas.FillRect(Rect);
        grdEstoque.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

end;

procedure TfrmProcura_Estoque.grdEstoqueKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
    begin
       if Assigned(frmOrcamento) then
       begin
           frmProcura_Estoque.Close;
           CarregaItensOrcamento();
       end;

       if Assigned(frmPDV) and (frmPDV.edtStatus.Text = 'Venda Aberta')then
       begin
           CarregaItensVenda();
           frmProcura_Estoque.Close;
           try
             frmQtde := TfrmQtde.Create(self);
             frmQtde.ShowModal;
           finally
             FreeAndNil(frmQtde);
           end;
       end;
    end;
end;

procedure TfrmProcura_Estoque.grdEstoqueTitleClick(Column: TColumn);
begin
    //Ordena os dados a partir do click no t�tulo da coluna
    dm.cdsEstoque.IndexFieldNames := Column.FieldName;
end;

procedure TfrmProcura_Estoque.rgOpcaoClick(Sender: TObject);
begin
    CarregaConsulta;
end;

end.
