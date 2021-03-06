unit uPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, FMTBcd, DB, SqlExpr, DBXCommon, uFormBase,
  pcnConversao;

type
   StatusVenda = (svAberto, svFechado);

type
  TfrmPDV = class(TFormBase)
    pnl1: TPanel;
    lbl1: TLabel;
    lblCaixa: TLabel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnlGrid: TPanel;
    grddbgrd: TDBGrid;
    pnl4: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtStatus: TEdit;
    edtProduto: TEdit;
    edtValor_Unitario: TEdit;
    edtSub_total: TEdit;
    edtTotal: TEdit;
    pnl5: TPanel;
    lbl8: TLabel;
    lblVenda: TLabel;
    lbl2: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lblData: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl16: TLabel;
    lblCod_Cli: TLabel;
    lbl15: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    edtConsulta: TEdit;
    lbl28: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure LimpaCampos();override;
    procedure NewVenda();
    procedure AlteraVenda();
    procedure FinalizarVenda();
    procedure CancelarItem();
    procedure CancelarVenda();
    procedure AtualizaCDSVenda();
    procedure CarregarItem(const TextoDigitado: string);
    function GeraNVenda: string;
    procedure grddbgrdCellClick(Column: TColumn);
    procedure grddbgrdDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtConsultaKeyPress(Sender: TObject; var Key: Char);
    //procedure GeraNfe();
  private
    { Private declarations }
  public
    sFStatus        : string;
    iFTipo_Pagamento: Integer;
    sFID_Funcionario: string;
    sFCod_cli       : string;
    dFDesconto      : Double;
    dFSub_total     : Double;
    dFTotal         : Double;
    bFResposta      : boolean;
    StatusPDV       : StatusVenda;
  end;

var
  frmPDV: TfrmPDV;
  Trans : TDBXTransaction;

implementation

uses uProcura_Estoque, uOrcamento, uProcura_Cliente, uProcura_Produto,
  UdmConexao, uDm, uQtde, uForma_Pagamento, uCancela_Item, uProcura_Venda;

{$R *.dfm}

procedure TfrmPDV.AlteraVenda;
begin
    //Procedimento para alterar uma venda j� finalizada
    if (sFStatus = 'F') and (dm.cdsItem_Venda.RecordCount > 0) then
    begin
         edtStatus.Text := 'Venda Aberta';
    end;
end;

procedure TfrmPDV.AtualizaCDSVenda;
begin
    try
         dm.cdsVenda.Close;
         dm.qryVenda.Close;
         dm.qryVenda.SQL.Clear;
         dm.qryVenda.SQL.Add('SELECT V.N_VENDA, V.DATA_VENDA, V.COD_CLI, V.VAL_TOTAL, V.ID_PAGAMENTO, P.TIPO_PAGAMENTO, ');
         dm.qryVenda.SQL.Add('V.COD_FUNC, V.STATUS, V.DESCONTO, V.SUB_TOTAL ');
         dm.qryVenda.SQL.Add('FROM VENDA V INNER JOIN PAGAMENTO P ON V.ID_PAGAMENTO = P.ID');
         dm.qryVenda.Open;
         dm.cdsVenda.Open;
    except
         on E:Exception do
             ShowMessage('Erro ao atualizar Vendas!'#13 + E.Message);
    end;
end;

procedure TfrmPDV.CancelarItem;
begin
    //Procedimento para cancelar item
    if StatusPDV = svAberto then
    begin
        frmCancelaItem := TfrmCancelaItem.Create(self);
        frmCancelaItem.ShowModal;
    end;
end;

procedure TfrmPDV.CancelarVenda;
begin
     //Procedimento para cancelar venda
     if StatusPDV = svAberto then
     begin
          if Application.MessageBox('Deseja cancelar essa Venda?', 'Confirma��o', MB_YESNO)= mrYes then
          begin
               if not dm.cdsItem_Venda.IsEmpty then
                  dm.cdsItem_Venda.EmptyDataSet;

               LimpaCampos;
               edtStatus.Text := 'Caixa Livre';
               StatusPDV      := svFechado;
          end;
     end;
end;

procedure TfrmPDV.CarregarItem(const TextoDigitado: string);
var
  qtde: integer;
  codigo: string;

  procedure DecomporCodigo(const ATexto: string; var AQuantidade: integer; var ACodigo: String);
  var
    PosicaoQuant: Integer;
    CodigoProduto: String;
  begin
      CodigoProduto := Trim(ATexto);
      PosicaoQuant  := pos('*', CodigoProduto);

      if PosicaoQuant > 0 then
      begin
        ACodigo     := Copy(CodigoProduto, PosicaoQuant + 1, Length(CodigoProduto));
        AQuantidade := StrToIntDef(Copy(CodigoProduto, 0, PosicaoQuant - 1), 1);
      end
      else
      begin
        ACodigo     := CodigoProduto;
        aQuantidade := 1;
      end;
  end;
begin
     DecomporCodigo(TextoDigitado, qtde, codigo);

     //Procedimento para carregar os itens na ClientDataSet de itens de venda
     dm.qryItem_Venda.close;
     dm.qryItem_Venda.SQL.Clear;
     dm.qryItem_Venda.SQL.Add(SELECT_ITEM);
     dm.qryItem_Venda.Open;

     dm.cdsItem_Venda.Open;

     //Cria um �ndice para ordenar pelo campo ID_ITEM
     dm.cdsItem_Venda.IndexFieldNames := 'ID_ITEM';

     dm.cdsEstoque.Open;

     // Verifica se o produto existe no cadastro
     if dm.cdsEstoque.Locate('EAN13', codigo, [loCaseInsensitive, loPartialKey]) then
     begin
         dm.cdsItem_Venda.Append;
         dm.cdsItem_Venda.FieldByName('ID_ITEM').AsInteger     := dm.cdsItem_Venda.RecordCount + 1;
         dm.cdsItem_Venda.FieldByName('N_VENDA').AsString      := frmPDV.lblVenda.Caption;
         dm.cdsItem_Venda.FieldByName('EAN13').AsString        := dm.cdsEstoque.FieldByName('EAN13').AsString;
         dm.cdsItem_Venda.FieldByName('DESC_PROD').AsString    := dm.cdsEstoque.FieldByName('DESC_PROD').AsString;
         dm.cdsItem_Venda.FieldByName('TIPO_ENTRADA').AsString := dm.cdsEstoque.FieldByName('TIPO_ENTRADA').AsString;
         dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat      := dm.cdsEstoque.FieldByName('VAL_VENDA').AsFloat;
         dm.cdsItem_Venda.FieldByName('TOTAL_PROD').AsFloat    := dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat * qtde;
         dm.cdsItem_Venda.FieldByName('QTDE').AsInteger        := qtde;
         dm.cdsItem_Venda.Post;
         dm.cdsEstoque.Close;

         frmPDV.edtProduto.Text           := dm.cdsItem_Venda.FieldByName('DESC_PROD').AsString;
         frmPDV.edtValor_Unitario.Text    := IntToStr(dm.cdsItem_Venda.FieldByName('QTDE').AsInteger) + ' x ' + FormatFloat('##0.00' ,dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat);
         frmPDV.edtSub_total.Text         := FormatFloat('##0.00' ,dm.cdsItem_Venda.FieldByName('TOTAL_PROD').AsFloat);
         frmPDV.edtTotal.Text             := FormatFloat('##0.00' ,dm.cdsItem_Venda.FieldByName('S_TOTAL').Value);
     end
     else
        MessageDlg('Produto n�o encontrado!', mtWarning, [mbOK], 0);
end;

procedure TfrmPDV.edtConsultaKeyPress(Sender: TObject; var Key: Char);
var
  TextoDigitado: string;

  function ContarCaracter(const ACaracter: Char; const ATexto: string): Integer;
  var
    Letra: Char;
  begin
    Result := 0;
    for Letra in ATexto do
    begin
      if Letra = ACaracter then
        Result := Result + 1;
    end;
  end;

begin
  try
    TextoDigitado := Trim(edtConsulta.Text);

    case Key of
      '*':
        begin
          // N�o deixar digitar mais de um multiplicador
          if (ContarCaracter('*', TextoDigitado) >= 1) then
            Key := #0;
        end;

      '.', ',':
        begin
          // N�o deixar digitar mais de uma virgula
          if (ContarCaracter(',', TextoDigitado) >= 1) then
            Key := #0
          else
            Key := ',';
        end;

      #13:
        begin
            if Trim(TextoDigitado) <> EmptyStr then
            begin
                edtConsulta.Enabled := False;
                try
                  if StatusPDV <> svAberto then
                  begin
                     Self.NewVenda;
                  end;

                  Self.CarregarItem(TextoDigitado);
                  edtConsulta.Clear;
                finally
                  edtConsulta.Enabled := True;
                  edtConsulta.SetFocus;
                end;
            end;
        end;
    end;
  except
      on E: exception do
      begin
          MessageDlg('Erro ao carregar item: ' + E.Message, mtWarning, [mbOK], 0);
      end;
  end;

  if not CharInSet(Key, ['0'..'9', '*', ',', #8]) then
    Key := #0;
end;

procedure TfrmPDV.FinalizarVenda;
var
  dValDesc: Double;
begin
     //Procedimento para finalizar venda

     //Verifica se existe uma Venda em Aberto
     if (StatusPDV = svAberto) and (not dm.cdsItem_Venda.IsEmpty) then
     begin
         //Carrega o Form para informar a forma de pagamento
         try
           frmForma_Pagamento := TfrmForma_Pagamento.Create(Self);
           frmForma_Pagamento.ShowModal;
         finally
           FreeAndNil(frmForma_Pagamento);
         end;

         //Verifica se o form forma de pagamento foi finalizado com sucesso
         if not bFResposta then
            Abort;

         //Verifica se a venda j� existe no banco de dados
         dm.cdsVenda.Open;
         if not (dm.cdsVenda.Locate('N_VENDA', lblVenda.Caption, [])) then
         begin

             //Verifica se foi informado algum valor para forma de pagamento
             if iFTipo_Pagamento > 0 then
             begin
                 try
                     Trans := dmConexao.Conexao.BeginTransaction;

                     //Inseri a venda na banco de dados
                     dm.qryVenda.Close;
                     dm.qryVenda.SQL.Clear;
                     dm.qryVenda.SQL.Add('INSERT INTO VENDA (N_VENDA, COD_CLI, DATA_VENDA, ID_PAGAMENTO, VAL_TOTAL, COD_FUNC, DESCONTO, SUB_TOTAL)'+
                                         'VALUES(:venda, :cli, :data, :tipo, :total, :func, :desc, :subtotal)');
                     dm.qryVenda.ParamByName('venda').AsString   := lblVenda.Caption;
                     dm.qryVenda.ParamByName('cli').AsString     := sFCod_cli;
                     dm.qryVenda.ParamByName('data').AsDate      := Now;
                     dm.qryVenda.ParamByName('tipo').AsInteger   := iFTipo_Pagamento;
                     dm.qryVenda.ParamByName('subtotal').AsFloat := dFSub_total;
                     dm.qryVenda.ParamByName('total').AsFloat    := dFTotal;
                     dm.qryVenda.ParamByName('desc').AsFloat     := dFDesconto;
                     dm.qryVenda.ParamByName('func').AsString    := sFID_Funcionario;
                     dm.qryVenda.ExecSQL();

                     // Verifica se existe desconto, se existir divide pela quantidade itens na venda
                     if dFDesconto > 0 then
                     begin
                         dValDesc := 0;
                         dValDesc := (dFDesconto / dm.cdsItem_Venda.RecordCount);

                         dm.cdsItem_Venda.First;
                         while not dm.cdsItem_Venda.Eof do
                         begin
                             dm.cdsItem_Venda.Edit;
                             dm.cdsItem_Venda.FieldByName('DESCONTO').AsFloat := dValDesc;
                             dm.cdsItem_Venda.Post;
                             dm.cdsItem_Venda.Next;
                         end;
                     end;

                     //Inseri os itens no banco de dados, limpa o DataSet e finaliza transa��o caso n�o ocorra erros
                     if dm.cdsItem_Venda.ApplyUpdates(0) > 0 then
                        raise Exception.Create('Falha ao gravar itens!');

                     dm.cdsItem_Venda.EmptyDataSet;
                     LimpaCampos();
                     edtStatus.Text := 'Caixa Livre';

                     //Finaliza a transa��o e descarrega o objeto
                     dmConexao.Conexao.CommitFreeAndNil(Trans);
                 except on E:Exception do
                      begin
                        raise Exception.Create('Erro ao gravar Venda:' + #13 +  E.message);
                        dmConexao.Conexao.RollbackFreeAndNil(Trans);
                      end;
                 end;
             end;
         end
         else
         begin
             try
                 Trans := dmConexao.Conexao.BeginTransaction;

                 //Atualiza venda no banco de dados
                 dm.qryVenda.Close;
                 dm.qryVenda.SQL.Clear;
                 dm.qryVenda.SQL.Add('UPDATE VENDA SET N_VENDA=:venda, COD_CLI=:cli, DATA_VENDA=:data, ID_PAGAMENTO=:tipo, VAL_TOTAL=:total, COD_FUNC=:func, DESCONTO=:desc, SUB_TOTAL=:subtotal '+
                                     'WHERE N_VENDA=:venda');
                 dm.qryVenda.ParamByName('venda').AsString   := lblVenda.Caption;
                 dm.qryVenda.ParamByName('cli').AsString     := sFCod_cli;
                 dm.qryVenda.ParamByName('data').AsDate      := Now;
                 dm.qryVenda.ParamByName('tipo').AsInteger   := iFTipo_Pagamento;
                 dm.qryVenda.ParamByName('subtotal').AsFloat := dFSub_total;
                 dm.qryVenda.ParamByName('total').AsFloat    := dFTotal;
                 dm.qryVenda.ParamByName('desc').AsFloat     := dFDesconto;
                 dm.qryVenda.ParamByName('func').AsString    := sFID_Funcionario;
                 dm.qryVenda.ParamByName('venda').AsString   := lblVenda.Caption;
                 dm.qryVenda.ExecSQL();

                 dValDesc := 0;
                 dValDesc := (dFDesconto / dm.cdsItem_Venda.RecordCount);
                 dm.cdsItem_Venda.First;
                 while not dm.cdsItem_Venda.Eof do
                 begin
                     dm.cdsItem_Venda.Edit;
                     dm.cdsItem_Venda.FieldByName('DESCONTO').AsFloat := dValDesc;
                     dm.cdsItem_Venda.Post;
                     dm.cdsItem_Venda.Next;
                 end;

                 //Inseri os itens no banco de dados, limpa o DataSet e finaliza transa��o caso n�o ocorra erros
                 if dm.cdsItem_Venda.ApplyUpdates(0) > 0 then
                    raise Exception.Create('Falha ao gravar itens!');

                 dm.cdsItem_Venda.EmptyDataSet;
                 LimpaCampos();
                 edtStatus.Text := 'Caixa Livre';

                 //Finaliza a transa��o e descarrega o objeto
                 dmConexao.Conexao.CommitFreeAndNil(Trans);
             except on E:Exception do
                  begin
                    raise Exception.Create('Erro ao gravar Venda:' + #13 +  E.message);
                  end;
             end;
         end;
         self.AtualizaCDSVenda;
         Self.StatusPDV := svFechado;
     end
     else
     begin
         ShowMessage('1 - N�o existe Venda em aberto'#10#13'2 - N�o existe itens nessa venda!');
     end;
end;

procedure TfrmPDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if StatusPDV = svAberto then
     begin
         MessageDlg('Existem uma venda em andamento, execute uma das sugest�es abaixo!'#13'- Finalize a venda.'#13'- Cancele a venda.', mtWarning, [mbOK], 0);
         Abort;
     end
     else
     begin
        dm.cdsVenda.Close;
        dm.cdsItem_Venda.Close;
        Action := caFree;
        frmPDV := nil;
     end;
end;

procedure TfrmPDV.FormCreate(Sender: TObject);
begin
    StatusPDV := svFechado;
    edtStatus.Text := 'Caixa Livre';
end;

procedure TfrmPDV.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
     inherited;
     if Key = VK_F1 then
     begin
          try
              frmProcura_Estoque := TfrmProcura_Estoque.Create(self);
              frmProcura_Estoque.ShowModal;
          finally
              FreeAndNil(frmProcura_Estoque);
          end;
     end;

     if Key = VK_F2 then NewVenda;
     if key = VK_F3 then FinalizarVenda;

     if (Key = VK_F4) and (not dm.cdsItem_Venda.IsEmpty) and (StatusPDV = svAberto) then
     begin
         try
            frmQtde := TfrmQtde.Create(self);
            frmQtde.ShowModal;
         finally
            FreeAndNil(frmQtde);
         end;
     end;

     if Key = VK_F5 then
     begin
          try
              frmOrcamento := TfrmOrcamento.Create(self);
              frmOrcamento.ShowModal;
          finally
               FreeAndNil(frmOrcamento);
          end;

     end;

     if Key = VK_F6 then
     begin
          CancelarVenda;
     end;

     if (Key = VK_F7) and (StatusPDV = svAberto) then
     begin
           try
               frmProcura_Cliente := TfrmProcura_Cliente.Create(self);
               frmProcura_Cliente.ShowModal;
           finally
               FreeAndNil(frmProcura_Cliente);
           end;
     end;

     if (Key = VK_F8) and (StatusPDV = svAberto) then
     begin
          try
              frmProcura_Estoque := TfrmProcura_Estoque.Create(self);
              frmProcura_Estoque.ShowModal;
          finally
              FreeAndNil(frmProcura_Estoque);
          end;
     end;

     if (Key = VK_F9) and (StatusPDV = svFechado) then
     begin
          try
              frmProcura_Venda := TfrmProcura_Venda.Create(self);
              frmProcura_Venda.ShowModal;
          finally
              FreeAndNil(frmProcura_Venda);
          end;
     end;

     if Key = VK_F11 then
     begin
         AlteraVenda();
     end;

     if Key = VK_DELETE then CancelarItem;
end;

procedure TfrmPDV.LimpaCampos;
begin
    inherited;
    lblVenda.Caption   := '';
    lblData.Caption    := '';
    lblCod_Cli.Caption := '';
    if not dm.cdsItem_Venda.IsEmpty then
       dm.cdsItem_Venda.EmptyDataSet;
end;

{procedure TfrmPDV.GeraNfe;
var
  NumItem: integer;
begin
    //Verifica se um registro foi selecionado
    if dm.cdsVenda.RecordCount = 0 then
    begin
         ShowMessage('� necess�rio selecionar um Pedido!');
         Abort;
    end;

    if not dm.Busca_ItemPedido(lblVenda.Caption) then
    begin
        ShowMessage('N�o existe itens nesse Pedido!');
        Abort;
    end;

    dm.ACBrNFe.NotasFiscais.Clear;

    //Repasse de informa��es para o componente ACBrNFe
    with dm.ACBrNFe.NotasFiscais.Add.NFe do
    begin
        Ide.cNF     := 000001;
        Ide.natOp   := 'VENDA';
        Ide.indPag  := ipVista;
        Ide.modelo  := 55;
        Ide.serie   := 1;
        Ide.nNF     := 000001;
        Ide.dEmi    := now;
        Ide.dSaiEnt := now;
        Ide.tpNF    := tnSaida;

        //Tipo de ambiente (0 - Produ��o, 1 - Homologa��o)
        if dmConexao.nAmbiente = 0 then
           Ide.tpAmb  := taProducao
        else
           Ide.tpAmb  := taHomologacao;

        Ide.verProc := '2.00';
        Ide.cUF     := dmConexao.nCod_UF;
        Ide.cMunFG  := dmConexao.nCod_municipio;
        Ide.finNFe  := fnNormal;

        //Dados do Emitente
        Emit.CNPJCPF           := dmConexao.sCNPJ;
        Emit.IE                := dmConexao.sI_E;
        Emit.IEST              := '';
        Emit.xNome             := dmConexao.sFantasia;
        Emit.xFant             := dmConexao.sFantasia;
        Emit.IM                := '';
        Emit.CNAE              := '';
        Emit.EnderEmit.xLgr    := dmConexao.sEndereco;
        Emit.EnderEmit.nro     := dmConexao.sNumero;
        Emit.EnderEmit.xCpl    := '';
        Emit.EnderEmit.xBairro := dmConexao.sBairro;
        Emit.EnderEmit.cMun    := dmConexao.nCod_municipio;
        Emit.EnderEmit.xMun    := dmConexao.sCidade;
        Emit.EnderEmit.UF      := dmConexao.sUF;
        Emit.EnderEmit.CEP     := StrToInt(dmConexao.sCEP);
        Emit.EnderEmit.fone    := dmConexao.sTelefone;
        Emit.EnderEmit.cPais   := dmConexao.nCod_pais;
        Emit.EnderEmit.xPais   := dmConexao.sPais;

        //Dados de Destinat�rio
        //Dest.CNPJCPF           :=
        //Dest.IE                :=
        //Dest.ISUF              :=
        //Dest.xNome             :=
        //Dest.EnderDest.xLgr    :=
        //Dest.EnderDest.nro     :=
        //Dest.EnderDest.xCpl    :=
        //Dest.EnderDest.xBairro :=
        //Dest.EnderDest.cMun    :=
        //Dest.EnderDest.xMun    :=
        //Dest.EnderDest.UF      :=
        //Dest.EnderDest.CEP     :=
        //Dest.EnderDest.cPais   :=
        //Dest.EnderDest.xPais   :=
        //Dest.EnderDest.fone    :=

        //Dados da Entrega
        //Entrega.xLgr           :=
        //Entrega.nro            :=
        //Entrega.xCpl           :=
        //Entrega.xBairro        :=
        //Entrega.cMun           :=
        //Entrega.xMun           :=
        //Entrega.UF             :=

        //Informa��es dos itens
        NumItem := 0;
        dm.cdsItem_Venda.First;
        while not dm.cdsItem_Venda.Eof do
        begin
             dm.Busca_Produto(dm.cdsItem_Venda.FieldByName('REF_PROD').AsString);
             Inc(NumItem);
             with Det.Add do
             begin
                 Prod.nItem   := NumItem;
                 Prod.cProd   := dm.cdsItem_Venda.FieldByName('REF_PROD').AsString;
                 Prod.cEAN    := dm.cdsProduto.FieldByName('EAN13').AsString;
                 Prod.xProd   := dm.cdsItem_Venda.FieldByName('DESC_PROD').AsString;
                 Prod.NCM     := dm.cdsProduto.FieldByName('CODIGO_NCM').AsString;
                 Prod.EXTIPI  := '';

                 case dm.cdsItem_Venda.FieldByName('TIPOPROD').AsInteger of
                     0, 1, 2, 4: Prod.CFOP := '5405';
                 else
                     Prod.CFOP    := '5405';
                 end;

                 Prod.uCom     := dm.cdsProduto.FieldByName('UND').AsString;
                 Prod.qCom     := dm.cdsItem_Venda.FieldByName('QTDE').AsFloat;
                 Prod.vUnCom   := dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat;

                 //Campos de Tributa��o
                 Prod.cEANTrib := '';
                 Prod.uTrib    := dm.cdsProduto.FieldByName('UND').AsString;
                 Prod.qTrib    := dm.cdsItem_Venda.FieldByName('QTDE').AsFloat;
                 Prod.vUnTrib  := dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat;

                 Prod.vFrete    := 0;
                 Prod.vSeg      := 0;
                 Prod.vProd     := dm.cdsItem_Venda.FieldByName('TOTAL_PROD').AsFloat;
                 Prod.vDesc     := 0;
                 Prod.IndTot    := itSomaTotalNFe;

                 with Imposto do
                 begin
                     with ICMS do
                     begin
                        CST         := cst41;
                        II.vBc      := 0;
                        II.vDespAdu := 0;
                        II.vII      := 0;
                        II.vIOF     := 0;
                     end;
                 end;
             end;
            dm.cdsItem_Venda.Next;
        end;

        Total.ICMSTot.vProd := dm.cdsVenda.FieldByName('VAL_TOTAL').AsFloat;
        Total.ICMSTot.vDesc := dm.cdsVenda.FieldByName('DESCONTO').AsFloat;
        Total.ICMSTot.vII   := 0;
        Total.ICMSTot.vDesc := 0;
        Total.ICMSTot.vNF   := dm.cdsVenda.FieldByName('VAL_TOTAL').AsFloat;
    end;

    dm.ACBrNFe.NotasFiscais.GerarNFe;
    dm.ACBrNFe.NotasFiscais.SaveToFile(dmConexao.sPath_Arquivo, false);
    ShowMessage('Arquivo xml gerado com sucesso! ' + dm.ACBrNFe.NotasFiscais.Items[0].NomeArq);
end;      }

function TfrmPDV.GeraNVenda: string;
var
   qryCodigo: TSQLQuery;
begin
    //Fun��o para gerar n�mero da Venda
    try
        try
            qryCodigo := TSQLQuery.Create(nil);
            qryCodigo.SQLConnection := dmConexao.Conexao;

            qryCodigo.Close;
            qryCodigo.SQL.Clear;
            qryCodigo.SQL.Add('SELECT CODIGO FROM sp_formata_numero(GEN_ID(gen_venda_id, 1), :dt)');
            qryCodigo.ParamByName('dt').AsString := FormatDateTime('mmyy', Now);
            qryCodigo.Open;

            Result := qryCodigo.Fields[0].AsString;
        except
            on E:Exception do
            ShowMessage('Erro gerar C�digo da Venda!'#13#10 + E.Message);
        end;
    finally
        FreeAndNil(qryCodigo);
    end;
end;

procedure TfrmPDV.grddbgrdCellClick(Column: TColumn);
begin
     //Carrega os valores no Form PDV
     edtProduto.Text        := dm.cdsItem_Venda.FieldByName('DESC_PROD').AsString;
     edtValor_Unitario.Text := IntToStr(dm.cdsItem_Venda.FieldByName('QTDE').AsInteger) + ' x ' + FormatFloat('##0.00', dm.cdsItem_Venda.FieldByName('VAL_PROD').AsFloat);
     edtSub_total.Text      := FormatFloat('##0.00' ,dm.cdsItem_Venda.FieldByName('TOTAL_PROD').AsFloat);
end;

procedure TfrmPDV.grddbgrdDblClick(Sender: TObject);
begin
    //Carrega o FormQtde para alterar a qtde do item
    if StatusPDV = svAberto then
    begin
        try
           frmQtde := TfrmQtde.Create(self);
           frmQtde.ShowModal;
        finally
           FreeAndNil(frmQtde);
        end;
    end;
end;

procedure TfrmPDV.NewVenda;
begin
     //Procedimento iniciar uma nova venda

     if StatusPDV = svFechado then
     begin
         LimpaCampos();
         lblCod_Cli.Caption  := '001';
         lblVenda.Caption    := GeraNVenda;
         lblData.Caption     := FormatDateTime('dd/mm/yy', Now);
         edtStatus.Text      := 'Venda Aberta';
         StatusPDV           := svAberto;
     end
     else
        MessageDlg('Existe uma venda em andamento!', mtWarning, [mbOK], 0);
end;

end.
