within IndustrialControlSystems.Controllers.Interfaces;
partial model BaseBlock "partial interface for a continuous time control block"
   parameter Real Ts = 0
    "|Discretisation| Sampling time (if <= 0 continuous time)"                     annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.RealInput u "input"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,126},{100,104}},
          lineColor={0,0,0},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Partial interface for a continuos/discrete time block.<br>
  The block has one input and one output (SISO). 
  </p>
  </HTML>",
        revisions="<html>
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
end BaseBlock;
