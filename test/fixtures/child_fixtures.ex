defmodule InfoCare.ChildFixtures do
  alias InfoCare.Child

  def child_1 service do
    %Child{
      ic_child_id: "672",
      service_id: service.id,
      dob: ~N[2009-08-21 00:00:00]
    }
  end

  def child_2 service do
    %Child{
      ic_child_id: "752",
      service_id: service.id,
      dob: ~N[2016-01-21 00:00:00]
    }
  end

  def child_3 service do
    %Child{
      ic_child_id: "735",
      service_id: service.id,
      dob: ~N[2014-06-01 09:00:00]
    }
  end
end
