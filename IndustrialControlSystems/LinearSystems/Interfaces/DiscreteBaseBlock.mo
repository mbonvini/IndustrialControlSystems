within IndustrialControlSystems.LinearSystems.Interfaces;
partial model DiscreteBaseBlock "Partial discrete time block interfaces"
  extends BaseBlock;
  parameter Real Ts= 0.01 "|Discretisation| Sampling time [s]";
  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=
      IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE
    "|Discretisation| Discretisation method";
protected
  Real alfa "discretisation coefficient";
equation
  if method == IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE then
    alfa = 1;
  elseif method == IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE then
    alfa = 0;
  elseif method == IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU then
    alfa = 0.5;
  else
    alfa = 1;
  end if;
  annotation (Icon(graphics={Polygon(
          points={{36,100},{100,36},{100,100},{36,100}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Partial interface for a discretised continuous time block.<br>
  Each block has a single input anda single output (SISO).<br>
  </p>
  <h4>Discretisation</h4>
  For each block is defined a sampling time <FONT FACE=Courier>Ts</FONT> and a coefficient alpha.<br>
  The discretisation of the continuos time transfer function has been performed with the bilinear transformation formula
  <pre>
                 z - 1 
  s = ------------------------------
        z*alpha*Ts - (alpha - 1)*Ts
  </pre>
  that is equivalent to<br>
  <ul>
  <li>Forward Euler (FE) if <pre><FONT FACE=Courier>alpha = 0</FONT></pre></li>
  <li>Backward Euler (BE) if <pre><FONT FACE=Courier>alpha = 1</FONT></pre></li>
  <li>Tustin (TU) if <pre><FONT FACE=Courier>alpha = 0.5</FONT></pre></li>
  </ul>
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
end DiscreteBaseBlock;
