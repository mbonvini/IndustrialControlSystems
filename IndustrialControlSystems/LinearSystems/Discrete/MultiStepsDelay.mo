within IndustrialControlSystems.LinearSystems.Discrete;
model MultiStepsDelay "Multistep time delay"
  extends LinearSystems.Interfaces.DiscreteBaseBlock;
  parameter Integer N = 1 "Fixed multi-step dalay";
  parameter Real y_start = 0 "Initial output value";
protected
  discrete Real buffer[N](each start = y_start);
algorithm
  assert(N>1,"The number of N steps delay must be positive");

  when sample(0,Ts) then

    for i in 2:N loop
      buffer[i] := pre(buffer[i-1]);
    end for;

    buffer[1] := u;

    y := buffer[N];

  end when;
  annotation (Icon(graphics={Text(
          extent={{-48,48},{30,-24}},
          lineColor={0,0,0},
          textString="e"), Text(
          extent={{4,50},{44,22}},
          lineColor={0,0,0},
          textString="-sNTs")}),  Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discrete version of the multistep time delay.
  <pre>
   Y(s) = e^(-s*N*Ts)*U(s)
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
end MultiStepsDelay;
