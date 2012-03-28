object Form1: TForm1
  Left = 192
  Top = 107
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 455
  ClientWidth = 634
  Color = clBtnFace
  Constraints.MaxHeight = 482
  Constraints.MaxWidth = 642
  Constraints.MinHeight = 50
  Constraints.MinWidth = 150
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GLSceneViewer1: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 634
    Height = 455
    Camera = GLCamera1
    Buffer.FogEnvironment.FogColor.Color = {C6BF3F3FDCD8583FDCD8583F0000803F}
    Buffer.FogEnvironment.FogStart = 10.000000000000000000
    Buffer.FogEnvironment.FogEnd = 1000.000000000000000000
    Buffer.FogEnvironment.FogDistance = fdEyePlane
    Buffer.ShadeModel = smSmooth
    FieldOfView = 155.209182739257800000
    Align = alClient
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
  end
  object GLScene1: TGLScene
    Left = 590
    Top = 16
    object GLWaterPlane1: TGLWaterPlane
      Material.FrontProperties.Ambient.Color = {A9A8283ECDCC4C3ECDCC4C3E0000803F}
      Material.FrontProperties.Emission.Color = {B1B0B03D9998183EF2F1713F0000803F}
      Material.BlendingMode = bmAdditive
      Position.Coordinates = {0000803FCDCC4CBD000000000000803F}
      Scale.Coordinates = {00007A4400007A4400007A4400000000}
      RainTimeInterval = 5000
      RainForce = 500.000000000000000000
      Viscosity = 0.990000009536743200
      Elastic = 1.000000000000000000
      SimulationFrequency = 100.000000000000000000
    end
    object SkyDome1: TGLSkyDome
      Direction.Coordinates = {000000000000803F2EBD3BB300000000}
      Up.Coordinates = {000000002EBD3BB3000080BF00000000}
      Bands = <
        item
          StartAngle = -5.000000000000000000
          StartColor.Color = {0000000000000000000000000000803F}
          StopAngle = 25.000000000000000000
          StopColor.Color = {0000000000000000000000410000803F}
          Slices = 9
        end
        item
          StartAngle = 25.000000000000000000
          StopAngle = 90.000000000000000000
          StopColor.Color = {0000804100000000000000000000803F}
          Slices = 9
          Stacks = 4
        end>
      Stars = <>
      Options = [sdoTwinkle]
    end
    object GLTerrainRenderer1: TGLTerrainRenderer
      Direction.Coordinates = {000000000000803F0000000000000000}
      Scale.Coordinates = {00008040000080400000803E00000000}
      Up.Coordinates = {00000000000000000000803F00000000}
      HeightDataSource = GLBitmapHDS1
      TilesPerTexture = 1.000000000000000000
      QualityDistance = 150.000000000000000000
    end
    object GLFreeForm1: TGLFreeForm
      Scale.Coordinates = {00004842000048420000484200000000}
      MaterialLibrary = GLMaterialLibrary1
    end
    object GLDummyCube1: TGLDummyCube
      Position.Coordinates = {0000803F0000803F0000803F0000803F}
      TurnAngle = 180.000000000000000000
      Up.Coordinates = {000000000000803F0000008000000000}
      CubeSize = 1.000000000000000000
      object GLLensFlare1: TGLLensFlare
        Size = 75
        Seed = 1465
        StreakWidth = 1.000000000000000000
        StreakAngle = 45.000000000000000000
        NumSecs = 0
        Resolution = 32
        AutoZTest = False
        FlareIsNotOccluded = True
        ObjectsSorting = osRenderNearestFirst
        Position.Coordinates = {000080BEF628DC3E000000000000803F}
        Visible = False
      end
      object GLActor1: TGLActor
        Material.Texture.Disabled = False
        Material.FaceCulling = fcNoCull
        Direction.Coordinates = {000000000000803F0000000000000000}
        RollAngle = 115.000000000000000000
        Up.Coordinates = {C90368BF000000006D61D83E00000000}
        Interval = 100
      end
      object GLCamera1: TGLCamera
        DepthOfView = 850.000000000000000000
        FocalLength = 50.000000000000000000
        TargetObject = GLDummyCube1
        Position.Coordinates = {000000000000803F000020400000803F}
        object GLLightSource1: TGLLightSource
          ConstAttenuation = 1.000000000000000000
          Position.Coordinates = {00004040000000400000803F0000803F}
          SpotCutOff = 180.000000000000000000
        end
      end
    end
    object GLSphere1: TGLSphere
      Material.FrontProperties.Emission.Color = {0000803F00000000000000000000803F}
      Scale.Coordinates = {00004040000040400000404000000000}
      Visible = False
      Radius = 0.500000000000000000
      EffectsData = {
        0201060A54474C4246697265465802000610474C4669726546584D616E616765
        7231}
    end
    object BeastCube: TGLDummyCube
      Position.Coordinates = {000000000000803F000048C20000803F}
      CubeSize = 1.000000000000000000
      object Beast: TGLActor
        Material.Texture.Disabled = False
        Direction.Coordinates = {000000800000803F0000000000000000}
        Up.Coordinates = {0000803F000000000000000000000000}
        Interval = 100
      end
    end
  end
  object GLCadencer1: TGLCadencer
    Scene = GLScene1
    OnProgress = GLCadencer1Progress
    Left = 494
    Top = 16
  end
  object GLMaterialLibrary1: TGLMaterialLibrary
    Left = 558
    Top = 16
  end
  object GLBitmapHDS1: TGLBitmapHDS
    MaxPoolSize = 0
    Left = 462
    Top = 16
  end
  object GLFireFXManager1: TGLFireFXManager
    Cadencer = GLCadencer1
    MaxParticles = 600
    ParticleSize = 5.000000000000000000
    FireDensity = 1.000000000000000000
    FireEvaporation = 0.860000014305114700
    FireRadius = 1.000000000000000000
    Disabled = True
    Paused = False
    ParticleInterval = 0.100000001490116100
    UseInterval = True
    Reference = GLSphere1
    Left = 526
    Top = 16
  end
  object Timer1: TTimer
    Interval = 300
    OnTimer = Timer1Timer
    Left = 462
    Top = 48
  end
end
