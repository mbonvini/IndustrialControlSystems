within IndustrialControlSystems.LinearSystems.Continuous;
model ComplexPoles "Process with complex poles"
  extends Interfaces.BaseBlock;
  parameter Real xi = 0.8 "|Block parameters| Damping coefficient";
  parameter Real omegan = 0.1 "|Block parameters| Natural frequency";
  parameter Real mu = 1 "|Block parameters| Gain";
  parameter Real y_start = 0 "|Initial conditions| Output initial value";
  parameter Real dy_start = 0 "|Initial conditions| Slope initial value";
  Real dy;
initial equation
  y  = y_start;
  dy = dy_start;
equation
  assert(xi>= 0 and xi <= 1,"Dumping coefficient must be between 0 and 1.");

  dy = der(y);
  mu*u = y + 2*xi/omegan*dy + der(dy)/(omegan^2);
  annotation (Icon(graphics={
        Text(
          extent={{-30,28},{28,12}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="mu"),
        Line(
          points={{-46,0},{48,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-46,-2},{52,-48}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*xi/w + (s/w)^2")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Continuous time transfer function of a process with complex poles.
  <pre>
   Y(s)                      1
   ----  = mu ------------------------------------
   U(s)        (1 + s*2*xi/omegan + (s/omegan)^2)
  </pre>
  <br>
  The damping coefficient <FONT FACE=Courier>xi</FONT> must be between <FONT FACE=Courier>[0,1]</FONT>.
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
end ComplexPoles;
