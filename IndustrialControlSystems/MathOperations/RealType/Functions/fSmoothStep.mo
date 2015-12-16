within IndustrialControlSystems.MathOperations.RealType.Functions;
function fSmoothStep "This function generates a smooth set point signal"
  input Real t;
  input Real tin;
  input Real alfa;
  input Real M;
  input Real yin;
  input Real yfin;
  output Real y;
protected
  Real a;
  Real tp;
  Real tr;
  Real parAsc;
  Real parDisc;
  Real retta;
  Real hp;
  Real m;
algorithm
  // modulus of m
  if
    (M>=0) then
    m := M;
  else
    m := -M;
  end if;

  if
    (alfa<=0) then
    // if alfa equals to zero, the set point signal is a ramp
    tp := 0;
    hp := 0;
    if
      (yfin>=yin) then
      tr := ((yfin-yin)-2*hp)/m;
      retta := m*(t-tin)+yin;
    else
      tr := ((yin-yfin)-2*hp)/m;
      retta := -m*(t-tin)+yin;
    end if;
  else
    // if alfa is different from zero, the set point signal is a ramp with parabolic connection
    if
      (yfin>=yin) then
      a := m/2/(alfa*(yfin-yin)/m);
      tp := m/(2*a);
      hp := m^2/(4*a);
      tr := ((yfin-yin)-2*hp)/m;
      parAsc := a*(t-tin)^2+yin;
      parDisc := -a*(t-tin-tr-2*tp)^2+yfin;
      retta := m*(t-tin-tp)+hp+yin;
    else
      a := m/2/(alfa*(yin-yfin)/m);
      tp := m/(2*a);
      hp := m^2/(4*a);
      tr := ((yin-yfin)-2*hp)/m;
      parAsc := -a*(t-tin)^2+yin;
      parDisc := a*(t-tin-tr-2*tp)^2+yfin;
      retta := -m*(t-tin-tp)+yin-hp;
    end if;
  end if;

  if (t>=0 and t<tin) then
    y := yin;
  elseif (t>=tin and t<tin+tp) then
    y := parAsc;
  elseif (t>=tin+tp and t<tin+tp+tr) then
    y := retta;
  elseif (t>=tin+tp+tr and t<=tin+2*tp+tr) then
    y := parDisc;
  else
    y := yfin;
  end if;

  annotation (Documentation(revisions="<html>
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
end fSmoothStep;
