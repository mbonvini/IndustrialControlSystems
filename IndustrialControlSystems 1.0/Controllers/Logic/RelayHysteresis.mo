within IndustrialControlSystems.Controllers.Logic;
model RelayHysteresis "Relay with hysteresis"
  extends IndustrialControlSystems.Controllers.Interfaces.BaseBlock;
  parameter Real Ymax = 1 "maximum output value" annotation(Evaluate = true);
  parameter Real Ymin = 0 "minimum output value" annotation(Evaluate = true);
  parameter Real ThL = 0 "input treshold (low) value" annotation(Evaluate = true);
  parameter Real ThH = 0 "input treshold (high) value" annotation(Evaluate = true);
  parameter Boolean initState = false "initial state" annotation(Evaluate = true);
protected
  discrete Boolean state( start = initState);
initial equation
  pre(state) = initState;
equation
  if Ts > 0 then
    // Discrete time relay
    when sample(0,Ts) then

      if (u >= ThH and not pre(state)) or (u <= ThL and pre(state)) then
        state = not pre(state);
      else
        state = pre(state);
      end if;

      if state then
        y = Ymax;
      else
        y = Ymin;
      end if;

    end when;
  else
    // continuous time relay
    if state then
      y = Ymax;
    else
      y = Ymin;
    end if;

    when (u >= ThH and not pre(state)) or (u <= ThL and pre(state)) then
      state = not pre(state);
    end when;
  end if;

  annotation (Icon(graphics={
        Line(
          points={{-76,-82},{22,-82},{22,88},{90,88}},
          color={0,0,255},
          smooth=Smooth.None),
        Polygon(
          points={{10,-6},{22,26},{34,-6},{10,-6}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-88,-82},{-34,-82},{-34,88},{34,88}},
          color={0,0,255},
          smooth=Smooth.None),
        Polygon(
          points={{-46,24},{-34,-8},{-22,24},{-46,24}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  On-Off relay with hysteresis controller.<br>
  <pre>
            1 if u(t) >= ThH and y(t) == 0
   y(t)  = 
            0 if u(t) &lt; ThL  and y(t) == 1
  </pre>
  
  <h4>Characteristic</h4><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Logic/RelayHystChar.png\"><br>
  If the sampling time parameter <FONT FACE=Courier>Ts</FONT> is less or equal to zero, ( <FONT FACE=Courier>Ts &lt;= 0</FONT> )
  The continuous time vesion is used, otherwise the discrete time one.
  
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
end RelayHysteresis;
