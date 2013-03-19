within IndustrialControlSystems.LinearSystems.Continuous;
model FirstOrder "First order process: mu/(1+tau*s)"
  extends Interfaces.BaseBlock;
  parameter Real tau = 2 "|Block parameters| pole's time constant";
  parameter Real mu = 1 "|Block parameters| Gain";
  parameter Real y_start = 0 "|Initial conditions| output initial value";
initial equation
  y = y_start;
equation
  y + tau*der(y) = mu*u;
  annotation (Icon(graphics={
        Text(
          extent={{-34,40},{32,6}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="mu"),
        Line(
          points={{-48,0},{46,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-42,-2},{36,-42}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*tau")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Continuous time transfer function of first order process.
  <pre>
   Y(s)         mu
   ----  = ------------
   U(s)      (1+s*tau)
  </pre>
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
end FirstOrder;
