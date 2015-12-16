within IndustrialControlSystems.Controllers;
model D "Real derivative controller"
  extends Interfaces.Controller;
  parameter Real Td = 1 "|Parameters| Derivative time" annotation(Evaluate = true);
  parameter Real N =  10 "|Parameters| Limitation of the derivative action"  annotation(Evaluate = true);
  Real Fin "Filtered input";
  Real satin "input of the saturation block";
initial equation

  if Ts > 0 then
    // Discrete time initialisation
    pre(Fin) = if AntiWindup then max(CSmin,min(CSmax,CS_start)) else CS_start - bias;
  else
    // Continuous time initialisation
    Fin = if AntiWindup then max(CSmin,min(CSmax,CS_start)) else CS_start - bias;
  end if;

equation

  if Ts > 0 then
    // Discrete time controller
    when sample(0,Ts) then
      CS    = if AntiWindup then max(CSmin,min(CSmax,satin)) else satin;
      satin = if ts then tr else N*(SP - PV) + pre(bias) - N*Fin;
      Fin = IndustrialControlSystems.LinearSystems.Discrete.Functions.f1Pole(
        alfa,
        SP - PV,
        pre(SP) - pre(PV),
        pre(Fin),
        Ts,
        1,
        Td/N);
    end when;
  else
    // Continuous time controller
    CS    = if AntiWindup then max(CSmin,min(CSmax,satin)) else satin;
    satin = if ts then tr else N*(SP - PV) + bias - N*Fin;
    Fin   = (SP - PV) - Td/N*der(Fin);
  end if;

  annotation (Icon(graphics={Text(
          extent={{-40,28},{40,-42}},
          lineColor={0,0,255},
          textString="D")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Real derivative controller with Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
              sTd
  CS(s) = ------------ (SP(s) - PV(S))
           1 + sTd/N
  </pre>
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Derivative.png\">
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
  
  In the Automatic mode, the control output is computed with the integral control law, while in the tracking mode<br>
  it is defined by the input TR.<br/><br/>
  To note that in the tracking mode the output signal CS is equal to TR.
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
end D;
