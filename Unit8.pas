unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TForm8 = class(TForm)
    EInput: TEdit;
    LVotreMot: TLabel;
    ECow: TEdit;
    EBull: TEdit;
    LCow: TLabel;
    LBull: TLabel;
    LEssais: TLabel;
    LLongueur: TLabel;
    Label1: TLabel;
    BValider: TButton;
    BRaZ: TButton;
    BQuit: TButton;
    MListe: TMemo;
    EAtrouver: TEdit;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BRaZClick(Sender: TObject);
    procedure BValiderClick(Sender: TObject);
    procedure BQuitClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form8: TForm8;

implementation //mDico.Lines.Count

{$R *.dfm}

//--------------------------PROCEDURE DE VERIFICATION-------------------------//
procedure gameTurn(input : string;tofind : string;Lcow : Tedit;Lbull : Tedit;Lessai : TLabel);
//On a doc ici besoin de l'input du joueur, du mot atrouver, et d'avoir accès au informations a updater.
VAR
  bull,cow,i,j : INTEGER;
BEGIN
input := lowercase(input);                                       //On met le mot en minuscule.
LEssai.caption := IntToStr(StrToInt(LEssai.caption)-1);          //On décompte un essai au joueur.
Cow := 0 ;
Bull := 0;
for i := 1 to length(Input) do                                   //On regarde dans tout le mot, lettre par lettre si il y a un bull.
   if Input[i] = tofind[i] then
   bull := bull +1
   else                                                          //Si on ne trouve pas de bull, on regarde pour une cow.
      for j := 1 to length(tofind) do
         BEGIN
         if input[i] = tofind[j] then
         cow := cow +1
         END;
Lcow.Text := IntTOStr(cow);                                     //On update les valeures.
LBUll.Text := inttostr(bull);
END;






//-----------------------------------QUITTER----------------------------------//
procedure TForm8.BQuitClick(Sender: TObject);
begin
  if MessageDlg('Voulez vous quitter?',
    mtConfirmation, [mbYes,mbNo], 0, mbYes) = mrYes then      //Bouton Quitter.
    close;
end;






//-------------------------------------RAZ------------------------------------//
procedure TForm8.BRaZClick(Sender: TObject);                  //Procedure de RaZ
begin
    EAtrouver.Text := MListe.Lines[random(MListe.Lines.Count)];//On reprends un mot au hasard.
    EInput.text := '';
    ECow.Text := '0';
    EBull.Text := '0';
    LLongueur.Caption := IntToStr(length(EATRouver.Text));
    EInput.ReadOnly := FALSE;
    Label1.Visible := FALSE;
    Label1.Caption := 'Gagné!';
    case length(EATrouver.Text) of
    3 : LEssais.Caption := '4';
    4 : LEssais.Caption := '7';
    5 : LEssais.Caption := '10';
    6 : LEssais.Caption := '14';
    7 : LEssais.Caption := '20';
    8 : LEssais.Caption := '25';
    9..20 : LEssais.Caption := '30';
    end;
    BValider.Enabled := TRUE;
end;





//------------------------BOUTON ET CONDITION DE VICTOIRES--------------------//
procedure TForm8.BValiderClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  bull: integer;
  cow:  integer;
begin
  if length(EInput.Text) <> length(EAtrouver.Text) then
    MessageDlg('Input n''est pas de la meme taille que le mot a trouver.',
    mtConfirmation, [mbYes],0)
  else
  BEGIN
    gameTurn(EInput.Text,EATrouver.Text,Ecow,Ebull,LEssais);

    if StrToInt(EBUll.Text) = length(EATRouver.Text) then
    BEGIN
      EInput.ReadOnly := TRUE;
      Label1.Visible := TRUE;
      BValider.Enabled := FALSE;
    END;

    if LEssais.Caption = '0' then
    BEGIN
      EInput.ReadOnly := TRUE;
      Label1.Caption := 'Perdu!';
      Label1.Visible := TRUE;
      BValider.Enabled := FALSE;
    END;
  END;
end;









//-----------------------------------INTIALISATION----------------------------//
procedure TForm8.FormCreate(Sender: TObject);

begin
    MListe.lines.LoadFromFile('BullAndCow.txt');
    EAtrouver.Text := MListe.Lines[random(MListe.Lines.Count)];
    LLongueur.Caption := IntToStr(length(EATRouver.Text));
    case length(EATrouver.Text) of
    3 : LEssais.Caption := '4';
    4 : LEssais.Caption := '7';
    5 : LEssais.Caption := '10';
    6 : LEssais.Caption := '14';
    7 : LEssais.Caption := '20';
    8 : LEssais.Caption := '25';
    9..20 : LEssais.Caption := '30';
    end;
end;

end.
