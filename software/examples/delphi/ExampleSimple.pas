program ExampleSimple;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletParticulateMatter;

type
  TExample = class
  private
    ipcon: TIPConnection;
    pm: TBrickletParticulateMatter;
  public
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change XYZ to the UID of your Particulate Matter Bricklet }

var
  e: TExample;

procedure TExample.Execute;
var pm10, pm25, pm100: word;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  pm := TBrickletParticulateMatter.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get current PM concentration }
  pm.GetPMConcentration(pm10, pm25, pm100);

  WriteLn(Format('PM 1.0: %d µg/m³', [pm10]));
  WriteLn(Format('PM 2.5: %d µg/m³', [pm25]));
  WriteLn(Format('PM 10.0: %d µg/m³', [pm100]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
