defmodule InfoCare.ChildFixtures do
  alias InfoCare.Child

  def child_1 service do
    %Child{
      ic_child_id: "672",
      service_id: service.id
    }
  end

  def child_2 service do
    %Child{
      ic_child_id: "752",
      service_id: service.id
    }
  end

  def child_3 service do
    %Child{
      ic_child_id: "735",
      service_id: service.id
    }
  end

  def child_4 service do
    %Child{
      ic_child_id: "748",
      service_id: service.id
    }
  end

  def child_5 service do
    %Child{
      ic_child_id: "755",
      service_id: service.id
    }
  end

  def child_6 service do
    %Child{
      ic_child_id: "742",
      service_id: service.id
    }
  end
end
