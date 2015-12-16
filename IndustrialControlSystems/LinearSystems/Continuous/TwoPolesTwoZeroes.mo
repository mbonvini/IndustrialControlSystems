within IndustrialControlSystems.LinearSystems.Continuous;
model TwoPolesTwoZeroes
  "Process with an integrator, 1 pole and 2 zeroes: mu(1+sT1)(1+sT2)/(1+sT3)s"
  extends Interfaces.BaseBlock;
  parameter Real mu = 1 "|Block parameters| Gain";
  parameter Real T1 = 4 "|Block parameters| first zero's time constant";
  parameter Real T2 = 2 "|Block parameters| second zero's time constant";
  parameter Real T3 = 10 "|Block parameters| pole's time constant";
  parameter Real y_start = 0 "|Initial conditions| Output initial value";
  Real dy;
  Real z;
  Real h;
protected
  parameter Real A = T2/T3;
  parameter Real B = 1 - A;
initial equation
  y = y_start;
equation
  assert(abs(A-1)>1e-8,"T2 must be != T3");

  z = T1*u + h;

  h + der(h) = z;

  dy + T3*der(dy) = mu*B*z;

  y = z*mu*A + dy;

  annotation (Icon(graphics={
        Text(
          extent={{-64,22},{78,6}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="mu(1+s*T1)(1+s*T2)"),
        Line(
          points={{-58,0},{76,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-44,-6},{58,-28}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="s*(1+s*T3)")}),
                                 Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Continuous time transfer function of a process with an integrator, one pole and two zeroes.
  <pre>
   Y(s)        (1 + s*T1)*(1 + s*T2)
   ----  = mu ----------------------
   U(s)            s*(1 + s*T3)
  </pre>
  <br>
  The time constants <FONT FACE=Courier>T1</FONT> and <FONT FACE=Courier>T2</FONT> must be different from <FONT FACE=Courier>T3</FONT>.
  </p>
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
end TwoPolesTwoZeroes;
