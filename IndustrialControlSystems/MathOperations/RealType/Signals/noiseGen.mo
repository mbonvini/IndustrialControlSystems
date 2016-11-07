within IndustrialControlSystems.MathOperations.RealType.Signals;
model noiseGen "Noise generator"
  extends Interfaces.RealNinOperation(final useInputs=false, final FixedPoint=false, final Nbit = 1, final scaleFactor = 1, final MAX = 1, final MIN = 0);
  parameter Modelica.SIunits.Time Ts = 0.1 "|Noise generator| Sampling time" annotation(Evaluate = true);
  parameter Real amp = 0.01 "|Noise generator| Amplitude" annotation(Evaluate = true);
  parameter Real Tf = 1 "|Noise generator| First order filter time constant" annotation(Evaluate = true);
  parameter Real X_start = 1 "|Noise generator| Initial value" annotation(Evaluate=true);
  constant Real m = 2^31 - 1 "|Algorithm| coefficient";
  constant Real a = 7^5 "|Algorithm| coefficient";
  constant Real c= 10 "|Algorithm| coefficient";
protected
  discrete Real X;
  discrete Real U;
equation
  // No Fixed Point here
  Ufp = zeros(nInput);
  Yfp = 0;
algorithm
  // initialisation
  when initial() then
     X := X_start;
  end when;

  // Random sample generator algorithm
  when noEvent(sample(0,Ts)) then
       X := (a*X+c)-div((a*X+c),m)*m;
       U := (X/2e9-0.5)*amp;
       y := (Tf*y+Ts*U)/(Tf+Ts);
  end when;
  annotation (Icon(graphics={Line(
          points={{-58,-50},{-46,72},{-42,36},{-32,86},{-32,-16},{-22,8},{-20,-2},
              {-18,0},{-12,72},{0,2},{4,40},{10,20},{22,52},{22,48},{26,-52},{32,
              -50},{32,-58},{40,-40},{44,-56},{50,-38},{54,-48},{56,-44},{66,78},
              {76,30},{76,28},{76,20}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5), Text(
          extent={{-100,124},{100,102}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Noise")}), Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of a noisy signal.<br><br>
  
  <img src=\"modelica://IndustrialControlSystems/help/images/Math/RealType/Signals/Noise.png\">
  <br><br>
  The output ( <FONT FACE=Courier>y</FONT> ) is the result of an algorithm that produces a sequence of pseudo random values.<br>
  The properties of the signal can be modified through the algorithm parameters: <FONT FACE=Courier>amp</FONT> and <FONT FACE=Courier>X_start</FONT>.<br>
  The output is filtered through a first order low pass filter, with time constant <FONT FACE=Courier>Ts</FONT>
  </p>
  <p><br><b>Fixed Point not available in this model</b>  </p>
  </HTML>", revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end noiseGen;
