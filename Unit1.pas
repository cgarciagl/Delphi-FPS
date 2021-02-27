unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, VectorGeometry,
  Dialogs, Keyboard, jpeg,  ExtCtrls, StdCtrls, Math, GLS.FireFX,
  GLS.HeightData, GLS.Material, GLS.Cadencer, GLS.Objects, GLS.Scene,
  GLS.VectorFileObjects, GLS.LensFlare, GLS.TerrainRenderer, GLS.SkyDome,
  GLS.Coordinates, GLS.WaterPlane, GLS.BaseClasses, GLS.FileMD2, GLS.SceneViewer, GLS.Color, Formats.MD2;

type
  TForm1 = class(TForm)
    GLScene1:           TGLScene;
    GLSceneViewer1:     TGLSceneViewer;
    GLCamera1:          TGLCamera;
    GLDummyCube1:       TGLDummyCube;
    GLActor1:           TGLActor;
    GLLightSource1:     TGLLightSource;
    GLCadencer1:        TGLCadencer;
    GLFreeForm1:        TGLFreeForm;
    GLMaterialLibrary1: TGLMaterialLibrary;
    GLBitmapHDS1:       TGLBitmapHDS;
    GLTerrainRenderer1: TGLTerrainRenderer;
    SkyDome1:           TGLSkyDome;
    GLSphere1:          TGLSphere;
    GLFireFXManager1:   TGLFireFXManager;
    Timer1:             TTimer;
    GLLensFlare1:       TGLLensFlare;
    GLWaterPlane1:      TGLWaterPlane;
    Beast:              TGLActor;
    BeastCube:          TGLDummyCube;
    procedure FormCreate (Sender: TObject);
    procedure GLSceneViewer1MouseMove (Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure GLSceneViewer1MouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure GLCadencer1Progress (Sender: TObject;
      const deltaTime, newTime: double);
    procedure Timer1Timer (Sender: TObject);
  private
    { Private declarations }
    mdx, mdy: integer;
    procedure PonBestiaAnimacion (x: integer);
  public
    { Public declarations }
    FCamHeight: single;
  end;

const
  animationdead = 6;
  cMoveSpeed    = 59;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate (Sender: TObject);
const
  scale = 3;
begin
  glwaterplane1.Visible    := True;
  GLBitmapHDS1.MaxPoolSize := 8 * 1024 * 1024;
  GLBitmapHDS1.Picture.LoadFromFile ('.\media\terrain.bmp');
  GLTerrainRenderer1.TilesPerTexture := 256 / GLTerrainRenderer1.TileSize;
  GLTerrainRenderer1.Material.Texture.Image.LoadFromFile ('.\media\tex.jpg');
  GLTerrainRenderer1.Material.Texture.Disabled := False;
  GLActor1.LoadFromFile ('.\media\weapon2.md2');
  GLActor1.Material.Texture.Image.LoadFromFile ('.\media\weapon2.jpg');
  GLActor1.Scale.SetVector (0.04, 0.04, 0.04, 0);
  GLActor1.AnimationMode := aamLoop;
  Beast.LoadFromFile ('.\media\mauler.md2');
  Beast.Material.Texture.Image.LoadFromFile ('.\media\mauler.jpg');
  Beast.Scale.SetVector (0.4, 0.4, 0.4, 0);
  Beast.AnimationMode := aamLoop;
  Beast.SwitchToAnimation (0);
 { with GLSoundLibrary1.Samples do
  begin
    Add.LoadFromFile('.\media\shoot.wav');
  end; }
  Skydome1.Stars.AddRandomStars (700, clWhite, True);
  FCamHeight := 30;
end;

procedure TForm1.GLSceneViewer1MouseMove (Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  mdx := x;
  mdy := y;
end;

procedure TForm1.GLSceneViewer1MouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  mdx := x;
  mdy := y;
end;

procedure TForm1.GLCadencer1Progress (Sender: TObject; const deltaTime, newTime: double);
var
  rayStart, rayVector, iPoint, iNormal, PActor: TVector;
begin
  GLSphere1.Material.FrontProperties.Emission.Color := clrRed;
  //Vemos a donde deberia apuntar la mira telescópica...
  SetVector (rayStart, GLCamera1.AbsolutePosition);
  SetVector (rayVector, GLSceneViewer1.Buffer.ScreenToVector (
    AffineVectorMake (200, {GLSceneViewer1.Height - 50} 400, 0)));
  NormalizeVector (rayVector);
  if GLTerrainRenderer1.RayCastIntersect (raystart, rayvector, @iPoint, @iNormal) then
  begin
    GLSphere1.Visible := True;
    if iPoint.Y < GLWaterPlane1.AbsolutePosition.Y then
    begin
      iPoint.Y := GLWaterPlane1.AbsolutePosition.Y;
      if (isKeyDown (VK_CONTROL)) then
      begin
        GLWaterPlane1.CreateRippleAtWorldPos (iPoint);
      end;
    end;
    GLSphere1.Position.AsVector  := iPoint;
    GLSphere1.Direction.AsVector := VectorNormalize (iNormal);
  end
  else
  begin
    GLSphere1.Visible := False;
  end;

  if Beast.RayCastIntersect (raystart, rayvector, @iPoint, @iNormal) then
  begin
    GLSphere1.Visible           := True;
    GLSphere1.Position.AsVector := iPoint;
    GLSphere1.Material.FrontProperties.Emission.Color := clrGreenYellow;
    if (isKeyDown (VK_CONTROL)) then
    begin
      PonBestiaAnimacion (animationdead);
      Beast.AnimationMode := aamPlayOnce;
    end;
  end;


  // Disparamos con la tecla Control...
  if (isKeyDown (VK_CONTROL)) then
  begin
    GLfireFXManager1.Disabled := False;
    if (GLActor1.CurrentAnimation <> GLActor1.Animations.Items[1].Name) then
    begin
      GLLensFlare1.Visible := True;
      GLActor1.SwitchToAnimation (1);
    {  with GetOrCreateSoundEmitter(GLCamera1) do begin
        Source.SoundLibrary := GLSoundLibrary1;
        Source.SoundName := GLSoundLibrary1.Samples[0].Name;
        Source.Volume := 1;
      end;    }
    end
    else
    begin
      GLLensFlare1.Visible := not GLLensFlare1.Visible;
    end;
   { with GetOrCreateSoundEmitter(GLCamera1) do
      if not Playing then Playing := True;}
  end
  else
    if GLActor1.CurrentAnimation <> GLActor1.Animations.Items[0].Name then
    begin
      GLActor1.SwitchToAnimation (0);
      GLLensFlare1.Visible      := False;
      // with GetOrCreateSoundEmitter(GLCamera1) do playing := False;
      GLfireFXManager1.Disabled := True;
    end;

  with GLCamera1.Position do
  begin
    if isKeyDown (VK_UP) then
    begin
      GLDummycube1.Move (-2);
    end;
    if isKeyDown (VK_DOWN) then
    begin
      GLDummycube1.Move (2);
    end;
    if iskeydown (VK_LEFT) then
    begin
      GLDummycube1.Turn (-1);
    end;
    if iskeydown (VK_RIGHT) then
    begin
      GLDummycube1.Turn (1);
    end;
  end;

  if iskeydown (VK_ESCAPE) then
  begin
    Close;
  end;

  with GLDummyCube1.Position do
  begin
    Y := GLTerrainRenderer1.InterpolatedHeight (AsVector) + FCamHeight;
  end;

  if (BeastCube.DistanceTo (GLDummyCube1) > 40) then
  begin
    if (not (Beast.CurrentAnimation = Beast.Animations.Items[animationdead].Name)) then
    begin
      with BeastCube.Position do
      begin
        Y := GLTerrainRenderer1.InterpolatedHeight (AsVector);
      end;
      PActor    := GLDummyCube1.Position.AsVector;
      PActor.Y := 0;
      BeastCube.PointTo (PActor, YHmgVector);
      BeastCube.Move (cMoveSpeed * deltaTime);
      PonBestiaAnimacion (1);
    end;
  end
  else
  begin
    Beast.AnimationMode := aamLoop;
    PonBestiaAnimacion (0);
  end;

  GLWaterPlane1.AbsolutePosition := GLDummyCube1.AbsolutePosition;
  GLWaterPlane1.Position.Y       := -15;
  GLSceneViewer1.Invalidate;
end;


procedure TForm1.PonBestiaAnimacion (x: integer);
begin
  if Beast.CurrentAnimation <> Beast.Animations.Items[x].Name then
  begin
    Beast.SwitchToAnimation (x);
  end;
end;

procedure TForm1.Timer1Timer (Sender: TObject);
begin
  Caption := Format ('%.2f FPS', [GLSceneViewer1.FramesPerSecond]);
  GLSceneViewer1.ResetPerformanceMonitor;
  if Beast.CurrentFrame = Beast.Animations.Items[animationdead].EndFrame then
  begin
    BeastCube.Move (-550);
    Beast.AnimationMode := aamLoop;
    PonBestiaAnimacion (0);
  end;
end;


end.
