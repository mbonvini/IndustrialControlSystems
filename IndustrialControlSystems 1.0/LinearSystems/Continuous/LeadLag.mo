within IndustrialControlSystems.LinearSystems.Continuous;
model LeadLag "Lead lag process: mu(1+T1*s)/(1+T2*s)"
  extends Interfaces.BaseBlock;
  parameter Real T1 = 3 "|Block parameters| zero's time constant";
  parameter Real T2 = 5 "|Block parameters| pole's time constant";
  parameter Real mu = 1 "|Block parameters| Gain";
  parameter Real y_start = 0 "|Initial conditions| output initial value";
  Real dy;
protected
  parameter Real A = T1/T2;
  parameter Real B = 1 - A;
initial equation
  dy = y_start;
equation
  assert(abs(A-1)>1e-8,"T1 must be != T2");
  dy + T2*der(dy) = mu*B*u;
  y = u*mu*A + dy;
  annotation (Icon(graphics={
        Text(
          extent={{-42,30},{60,8}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*T1"),
        Line(
          points={{-40,0},{54,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-42,-14},{60,-36}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*T2")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Continuous time transfer function of a lead lag process.
  <pre>
   Y(s)        (1 + s*T1)
   ----  = mu ------------
   U(s)        (1 + s*T2)
  </pre>
  <br>
  The time constant <FONT FACE=Courier>T1</FONT> must be different from <FONT FACE=Courier>T2</FONT>.
  </p>
  </HTML>", revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &LT;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&GT;</dd>
<dd>Alberto Leva &LT;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&GT;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end LeadLag;
