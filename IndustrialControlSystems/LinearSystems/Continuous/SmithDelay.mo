within IndustrialControlSystems.LinearSystems.Continuous;
model SmithDelay "Time delay block for Smith's predictor"
  extends LinearSystems.Interfaces.BaseBlock;
  parameter Real T = 1 "Fixed delay time";
equation
  assert(T>=0,"Delay constant must be positive");

  y = u - delay(u,T);
  annotation (Icon(graphics={Text(
          extent={{-60,28},{30,-22}},
          lineColor={0,0,0},
          textString="1-e"),
                           Text(
          extent={{10,38},{50,10}},
          lineColor={0,0,0},
          textString="-sT")}),  Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Continuous time delay block for the Smith's predictor.
  <pre>
   Y(s) = (1 - e^(-s*T))*U(s)
  </pre>
  <br>
  The delay must be positive <FONT FACE=Courier>T &gt;= 0</FONT>.
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
end SmithDelay;
