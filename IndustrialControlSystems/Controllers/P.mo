within IndustrialControlSystems.Controllers;
model P "Proportional controller"
  extends Interfaces.Controller;
  parameter Real Kp = 5 "|Parameters| Proportional gain" annotation(Evaluate = true);
  Real Pout "output of the proportional block";
  Real satin "input of the saturation block";
equation

  if Ts > 0 then
    // Discrete time controller
    when sample(0,Ts) then
      CS    = if AntiWindup then max(CSmin,min(CSmax,satin)) else satin;
      satin = if ts then tr else Pout;
      Pout  = Kp*(SP-PV) + pre(bias);
    end when;
  else
    // Continuous time controller
    CS    = if AntiWindup then max(CSmin,min(CSmax,satin)) else satin;
    satin = if ts then tr else Pout;
    Pout  = Kp*(SP-PV) + bias;
  end if;

  annotation (Icon(graphics={Text(
          extent={{-30,28},{50,-42}},
          lineColor={0,0,255},
          textString="P")}), Diagram(graphics),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Proportional controller with Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
  CS(s) = Kp*(SP(s) - PV(s))
  </pre>
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Proportional.png\">
  
  <br/><br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (*)</td></tr>
  </table>
  (*) AutoTuning Not available here, please see the package<br>
  <a href=\"Modelica://IndustrialControlSystems.Controllers.AutoTuning\">AutoTuning</a>
  <br/><br/>
  The controller can have various operating conditions:
  <ul>
  <li>Automatic,</li>
  <li>and Tracking</li>
  </ul><br/>
  
  In the Automatic mode, the control output is computed with the proportional control law, while in the tracking mode<br>
  it is defined by the input TR. 
  </p>
  </HTML>",
          revisions="<html>
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
end P;
